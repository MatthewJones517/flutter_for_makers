import 'dart:async';

import 'package:flockinator/src/features/flock_scan/domain/dash_model.dart';
import 'package:flockinator/src/shared/firebase/data/firebase_database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_database_service.g.dart';

@riverpod
class FirebaseDatabaseService extends _$FirebaseDatabaseService {
  @override
  Future<List<DashModel>> build() async {
    final databaseRef = ref.watch(firebaseDatabaseRepositoryProvider);
    final activeConferenceId = await _getActiveConferenceId();

    // Set up the listener for database changes
    databaseRef.child('publicDashDetails/$activeConferenceId').onValue.listen((
      event,
    ) {
      if (event.snapshot.value != null) {
        final dashes = (event.snapshot.value as List<dynamic>).map((item) {
          final Map<String, dynamic> dash = Map<String, dynamic>.from(
            item as Map,
          );
          return DashModel.fromJson(dash);
        }).toList();

        // Update the notifier state with new data
        state = AsyncValue.data(dashes);
      }
    });

    // Return initial empty list - the listener will update with real data
    return [];
  }

  Future<String> _getActiveConferenceId() async {
    try {
      final query = ref
          .watch(firebaseDatabaseRepositoryProvider)
          .child('conferenceSets')
          .orderByChild('isActive')
          .equalTo(true)
          .limitToFirst(1);

      final conferenceSnapshot = await query.get();

      if (!conferenceSnapshot.exists || conferenceSnapshot.value == null) {
        throw Exception('No active conference found.');
      }

      final conferenceData = conferenceSnapshot.value as Map;
      final String activeConferenceName = conferenceData.keys.first;

      return activeConferenceName;
    } catch (e) {
      return "";
    }
  }
}
