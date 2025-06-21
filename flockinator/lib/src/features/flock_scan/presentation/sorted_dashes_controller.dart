import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import 'package:flockinator/src/features/flock_scan/domain/dash_model.dart';
import 'package:flockinator/src/features/flock_scan/application/flock_scan_service.dart';
import 'package:flockinator/src/shared/firebase/application/firebase_database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sorted_dashes_controller.g.dart';

@riverpod
AsyncValue<List<DashModel>> sortedDashesController(Ref ref) {
  final dashes = ref.watch(firebaseDatabaseServiceProvider);

  return dashes.when(
    data: (dashList) {
      final Map<DashModel, Proximity?> dashProximities = dashList
          .fold<Map<DashModel, Proximity?>>(<DashModel, Proximity?>{}, (
            map,
            dash,
          ) {
            map[dash] = ref
                .watch(
                  flockScanServiceProvider(
                    major: dash.major,
                    minor: dash.minor,
                  ),
                )
                ?.proximity;
            return map;
          });

      return AsyncValue.data(_sortDashes(ref, dashProximities));
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
}

List<DashModel> _sortDashes(Ref ref, Map<DashModel, Proximity?> dashes) {
  try {
    final sortedEntries = dashes.entries.toList()
      ..sort((a, b) {
        try {
          final dashA = a.key;
          final dashB = b.key;
          final proximityA = a.value;
          final proximityB = b.value;

          if (!dashA.active && dashB.active) return 1;
          if (dashA.active && !dashB.active) return -1;

          if (!dashA.active && !dashB.active) {
            return dashA.name.compareTo(dashB.name);
          }

          if (dashA.active && dashB.active) {
            final proximityOrderA = _getProximityOrder(proximityA);
            final proximityOrderB = _getProximityOrder(proximityB);

            if (proximityOrderA != proximityOrderB) {
              return proximityOrderA.compareTo(proximityOrderB);
            }

            return dashA.name.compareTo(dashB.name);
          }

          return 0;
        } catch (e) {
          return 0;
        }
      });

    return sortedEntries.map((entry) => entry.key).toList();
  } catch (e) {
    return dashes.keys.toList();
  }
}

int _getProximityOrder(Proximity? proximity) {
  try {
    switch (proximity) {
      case Proximity.immediate:
        return 0;
      case Proximity.near:
        return 1;
      case Proximity.far:
      case Proximity.unknown:
        return 2;
      case null:
        return 3;
    }
  } catch (e) {
    return 3;
  }
}
