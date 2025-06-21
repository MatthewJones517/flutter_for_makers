import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_functions_repository.g.dart';

class FirebaseFunctionsRepository {
  late final FirebaseFunctions _functions;

  FirebaseFunctionsRepository() {
    _functions = FirebaseFunctions.instanceFor(region: 'europe-west1');
  }

  Future<bool> deactivateElementByGuid(String guid) async {
    final HttpsCallable callable = _functions.httpsCallable(
      'deactivateElementByGuid',
    );

    try {
      final HttpsCallableResult<Map<String, dynamic>> result = await callable
          .call<Map<String, dynamic>>({'guid': guid});

      return result.data['success'] == true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> activateElementByGuid(String guid) async {
    final HttpsCallable callable = _functions.httpsCallable(
      'activateElementByGuid',
    );

    try {
      final HttpsCallableResult<Map<String, dynamic>> result = await callable
          .call<Map<String, dynamic>>({'guid': guid});

      return result.data['success'] == true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkElementActiveStatus(String guid) async {
    final HttpsCallable callable = _functions.httpsCallable(
      'checkElementActiveStatus',
    );

    try {
      final HttpsCallableResult<Map<String, dynamic>> result = await callable
          .call<Map<String, dynamic>>({'guid': guid});

      return result.data['active'] == true;
    } catch (e) {
      return false;
    }
  }
}

@riverpod
FirebaseFunctionsRepository firebaseFunctionsRepository(Ref ref) {
  return FirebaseFunctionsRepository();
}
