import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/permission_handler_repository.dart';

part 'permissions_service.g.dart';

class PermissionsService {
  final PermissionHandlerRepository _repository;

  PermissionsService(this._repository);

  Future<bool> isBluetoothGranted() {
    return _repository.isBluetoothGranted();
  }

  Future<bool> requestBluetoothPermission() {
    return _repository.requestBluetoothPermission();
  }

  Future<bool> isLocationGranted() {
    return _repository.isLocationGranted();
  }

  Future<bool> requestLocationPermission() {
    return _repository.requestLocationPermission();
  }
}

@riverpod
PermissionsService permissionsService(Ref ref) {
  final repository = ref.watch(permissionHandlerRepositoryProvider);
  return PermissionsService(repository);
}
