import 'dart:async';
import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/flock_scan_model.dart';

part 'flock_scan_repository.g.dart';

@riverpod
Stream<FlockScanModel> flockScanRepository(Ref ref) {
  final controller = StreamController<FlockScanModel>();

  _initializeScanning(controller);

  return controller.stream;
}

Future<void> _initializeScanning(
  StreamController<FlockScanModel> controller,
) async {
  final regions = <Region>[];

  regions.add(
    Region(
      identifier: 'Dash Tags',
      proximityUUID: '1e39ed8e-5575-4c82-9772-b7f660b19b06',
    ),
  );

  await flutterBeacon.initializeScanning;

  flutterBeacon.ranging(regions).listen((RangingResult result) {
    final beacons = result.beacons;
    for (final beacon in beacons) {
      final flockScanModel = FlockScanModel(
        proximityUUID: beacon.proximityUUID.toString(),
        rssi: beacon.rssi,
        accuracy: beacon.accuracy,
        proximity: beacon.proximity,
        major: beacon.major,
        minor: beacon.minor,
        macAddress: beacon.macAddress.toString(),
        timestamp: DateTime.now(),
      );

      controller.add(flockScanModel);
    }
  });
}
