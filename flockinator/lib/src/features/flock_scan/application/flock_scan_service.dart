import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/flock_scan_model.dart';
import '../data/flock_scan_repository.dart';
import 'dart:async';

part 'flock_scan_service.g.dart';

@riverpod
class FlockScanService extends _$FlockScanService {
  Timer? _timer;

  @override
  FlockScanModel? build({required int major, required int minor}) {
    // Listen to the flockScanRepository stream and update state when a matching beacon is found
    ref.listen<AsyncValue<FlockScanModel>>(flockScanRepositoryProvider, (
      previous,
      next,
    ) {
      next.whenData((flockScan) {
        if (flockScan.major == major && flockScan.minor == minor) {
          state = flockScan;
          // Cancel any previous timer
          _timer?.cancel();
          _timer = Timer(const Duration(seconds: 10), () {
            if (state != null &&
                DateTime.now().difference(state!.timestamp) >
                    const Duration(seconds: 10)) {
              state = null;
            }
          });
        }
      });
    });

    // Periodically check if the state is stale (in case the timer is missed)
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (state != null &&
          DateTime.now().difference(state!.timestamp) >
              const Duration(seconds: 10)) {
        state = null;
      }
    });

    ref.onDispose(() {
      _timer?.cancel();
    });

    return null;
  }
}
