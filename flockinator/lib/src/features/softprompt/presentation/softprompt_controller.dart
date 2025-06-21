import 'package:flockinator/src/shared/permissions/application/permissions_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'softprompt_controller.g.dart';

// Controller class for soft prompt logic
class SoftPromptController {
  final PermissionsService _permissionsService;

  SoftPromptController(this._permissionsService);

  Future<bool> requestPermissions() async {
    final bluetoothGranted = await _permissionsService
        .requestBluetoothPermission();
    final locationGranted = await _permissionsService
        .requestLocationPermission();
    return bluetoothGranted && locationGranted;
  }

  /// Checks if Bluetooth permission has been granted.
  Future<bool> isBluetoothGranted() {
    return _permissionsService.isBluetoothGranted();
  }
}

@riverpod
SoftPromptController softPromptController(Ref ref) {
  final permissionsService = ref.watch(permissionsServiceProvider);
  return SoftPromptController(permissionsService);
}
