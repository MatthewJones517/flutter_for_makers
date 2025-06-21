import 'package:flockinator/src/shared/firebase/data/firebase_functions_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_functions_service.g.dart';

class FirebaseFunctionsService {
  late final FirebaseFunctionsRepository _firebaseFunctionsRepository;

  FirebaseFunctionsService(this._firebaseFunctionsRepository);

  Future<bool> deactivateElementByGuid(String guid) {
    return _firebaseFunctionsRepository.deactivateElementByGuid(guid);
  }

  Future<bool> activateElementByGuid(String guid) {
    return _firebaseFunctionsRepository.activateElementByGuid(guid);
  }

  Future<bool> checkElementActiveStatus(String guid) {
    return _firebaseFunctionsRepository.checkElementActiveStatus(guid);
  }
}

@riverpod
FirebaseFunctionsService firebaseFunctionsService(Ref ref) {
  return FirebaseFunctionsService(
    ref.watch(firebaseFunctionsRepositoryProvider),
  );
}
