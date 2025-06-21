import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flock_scan_model.freezed.dart';

@freezed
abstract class FlockScanModel with _$FlockScanModel {
  const factory FlockScanModel({
    required String proximityUUID,
    required int rssi,
    required double accuracy,
    required Proximity proximity,
    required int major,
    required int minor,
    required String macAddress,
    required DateTime timestamp,
  }) = _FlockScanModel;
}
