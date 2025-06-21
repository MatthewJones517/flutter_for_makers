import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../application/permissions_service.dart';

part 'permission_router_controller.g.dart';

class PermissionRouterController {
  final PermissionsService _permissionsService;

  PermissionRouterController(this._permissionsService);

  Future<bool> arePermissionsGranted() async {
    final bluetoothGranted = await _permissionsService.isBluetoothGranted();
    final locationGranted = await _permissionsService.isLocationGranted();
    return bluetoothGranted && locationGranted;
  }

  Future<void> requestPermissions() async {
    await _permissionsService.requestBluetoothPermission();
    await _permissionsService.requestLocationPermission();
  }
}

@riverpod
PermissionRouterController permissionRouterController(Ref ref) {
  final permissionsService = ref.watch(permissionsServiceProvider);
  return PermissionRouterController(permissionsService);
}
