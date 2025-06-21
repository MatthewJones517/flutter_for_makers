import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_handler_repository.g.dart';

class PermissionHandlerRepository {
  Future<bool> isBluetoothGranted() async {
    final status = await Permission.bluetooth.status;
    return status.isGranted;
  }

  Future<bool> requestBluetoothPermission() async {
    final bluetoothStatus = await Permission.bluetooth.request();

    final bool bluetoothScanGranted = (Platform.isAndroid)
        ? await Permission.bluetoothScan.request().isGranted
        : true;

    return bluetoothStatus.isGranted && bluetoothScanGranted;
  }

  Future<bool> isLocationGranted() async {
    final status = await Permission.locationWhenInUse.status;
    return status.isGranted;
  }

  Future<bool> requestLocationPermission() async {
    final locationStatus = await Permission.locationWhenInUse.request();
    return locationStatus.isGranted;
  }
}

@riverpod
PermissionHandlerRepository permissionHandlerRepository(Ref ref) {
  return PermissionHandlerRepository();
}
