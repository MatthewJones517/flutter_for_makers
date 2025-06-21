import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flockinator/src/shared/firebase/application/firebase_functions_service.dart';

part 'claim_controller.g.dart';

class ClaimController {
  final FirebaseFunctionsService _firebaseFunctionsService;

  ClaimController(this._firebaseFunctionsService);

  Future<bool> deactivateElementByGuid(String guid) {
    return _firebaseFunctionsService.deactivateElementByGuid(guid);
  }

  Future<bool> activateElementByGuid(String guid) {
    return _firebaseFunctionsService.activateElementByGuid(guid);
  }

  Future<bool> checkElementActiveStatus(String guid) {
    return _firebaseFunctionsService.checkElementActiveStatus(guid);
  }
}

@riverpod
ClaimController claimController(Ref ref) {
  return ClaimController(ref.watch(firebaseFunctionsServiceProvider));
}
