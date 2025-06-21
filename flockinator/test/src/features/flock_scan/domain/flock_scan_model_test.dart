import 'package:flutter_test/flutter_test.dart';
import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import 'package:flockinator/src/features/flock_scan/domain/flock_scan_model.dart';

void main() {
  group('FlockScanModel', () {
    test('should create FlockScanModel with all required fields', () {
      // Arrange
      const proximityUUID = '1e39ed8e-5575-4c82-9772-b7f660b19b06';
      const rssi = -50;
      const accuracy = 1.0;
      const proximity = Proximity.immediate;
      const major = 1;
      const minor = 2;
      const macAddress = '00:00:00:00:00:00';
      final timestamp = DateTime.now();

      // Act
      final flockScanModel = FlockScanModel(
        proximityUUID: proximityUUID,
        rssi: rssi,
        accuracy: accuracy,
        proximity: proximity,
        major: major,
        minor: minor,
        macAddress: macAddress,
        timestamp: timestamp,
      );

      // Assert
      expect(flockScanModel.proximityUUID, proximityUUID);
      expect(flockScanModel.rssi, rssi);
      expect(flockScanModel.accuracy, accuracy);
      expect(flockScanModel.proximity, proximity);
      expect(flockScanModel.major, major);
      expect(flockScanModel.minor, minor);
      expect(flockScanModel.macAddress, macAddress);
      expect(flockScanModel.timestamp, timestamp);
    });

    test('should create FlockScanModel with different proximity values', () {
      // Test immediate proximity
      final immediateModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -30,
        accuracy: 0.5,
        proximity: Proximity.immediate,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:01',
        timestamp: DateTime.now(),
      );

      expect(immediateModel.proximity, Proximity.immediate);
      expect(immediateModel.rssi, -30);
      expect(immediateModel.accuracy, 0.5);

      // Test near proximity
      final nearModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -60,
        accuracy: 2.0,
        proximity: Proximity.near,
        major: 2,
        minor: 2,
        macAddress: '00:00:00:00:00:02',
        timestamp: DateTime.now(),
      );

      expect(nearModel.proximity, Proximity.near);
      expect(nearModel.rssi, -60);
      expect(nearModel.accuracy, 2.0);

      // Test far proximity
      final farModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -80,
        accuracy: 5.0,
        proximity: Proximity.far,
        major: 3,
        minor: 3,
        macAddress: '00:00:00:00:00:03',
        timestamp: DateTime.now(),
      );

      expect(farModel.proximity, Proximity.far);
      expect(farModel.rssi, -80);
      expect(farModel.accuracy, 5.0);

      // Test unknown proximity
      final unknownModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -100,
        accuracy: 10.0,
        proximity: Proximity.unknown,
        major: 4,
        minor: 4,
        macAddress: '00:00:00:00:00:04',
        timestamp: DateTime.now(),
      );

      expect(unknownModel.proximity, Proximity.unknown);
      expect(unknownModel.rssi, -100);
      expect(unknownModel.accuracy, 10.0);
    });

    test('should handle different RSSI values', () {
      // Test strong signal
      final strongSignalModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -20,
        accuracy: 0.3,
        proximity: Proximity.immediate,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:01',
        timestamp: DateTime.now(),
      );

      expect(strongSignalModel.rssi, -20);
      expect(strongSignalModel.accuracy, 0.3);

      // Test weak signal
      final weakSignalModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -90,
        accuracy: 8.0,
        proximity: Proximity.far,
        major: 2,
        minor: 2,
        macAddress: '00:00:00:00:00:02',
        timestamp: DateTime.now(),
      );

      expect(weakSignalModel.rssi, -90);
      expect(weakSignalModel.accuracy, 8.0);
    });

    test('should handle different major and minor values', () {
      // Test with high major/minor values
      final highValuesModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.near,
        major: 65535, // Max value for major
        minor: 65535, // Max value for minor
        macAddress: 'FF:FF:FF:FF:FF:FF',
        timestamp: DateTime.now(),
      );

      expect(highValuesModel.major, 65535);
      expect(highValuesModel.minor, 65535);
      expect(highValuesModel.macAddress, 'FF:FF:FF:FF:FF:FF');

      // Test with zero values
      final zeroValuesModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.near,
        major: 0,
        minor: 0,
        macAddress: '00:00:00:00:00:00',
        timestamp: DateTime.now(),
      );

      expect(zeroValuesModel.major, 0);
      expect(zeroValuesModel.minor, 0);
      expect(zeroValuesModel.macAddress, '00:00:00:00:00:00');
    });

    test('should handle different timestamp values', () {
      // Test with current timestamp
      final now = DateTime.now();
      final currentModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.near,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: now,
      );

      expect(currentModel.timestamp, now);

      // Test with past timestamp
      final pastTime = DateTime.now().subtract(const Duration(hours: 1));
      final pastModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.near,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: pastTime,
      );

      expect(pastModel.timestamp, pastTime);

      // Test with future timestamp
      final futureTime = DateTime.now().add(const Duration(hours: 1));
      final futureModel = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.near,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: futureTime,
      );

      expect(futureModel.timestamp, futureTime);
    });

    test('should support equality comparison', () {
      // Arrange
      final timestamp = DateTime.now();
      final model1 = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.immediate,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: timestamp,
      );

      final model2 = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.immediate,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: timestamp,
      );

      final model3 = FlockScanModel(
        proximityUUID: 'different-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.immediate,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: timestamp,
      );

      // Act & Assert
      expect(model1, equals(model2));
      expect(model1, isNot(equals(model3)));
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('should support copyWith method', () {
      // Arrange
      final originalModel = FlockScanModel(
        proximityUUID: 'original-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.immediate,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: DateTime.now(),
      );

      // Act
      final copiedModel = originalModel.copyWith(
        proximityUUID: 'copied-uuid',
        rssi: -60,
        proximity: Proximity.near,
      );

      // Assert
      expect(copiedModel.proximityUUID, 'copied-uuid');
      expect(copiedModel.rssi, -60);
      expect(copiedModel.proximity, Proximity.near);
      expect(copiedModel.accuracy, 1.0); // Should remain unchanged
      expect(copiedModel.major, 1); // Should remain unchanged
      expect(copiedModel.minor, 1); // Should remain unchanged
      expect(
        copiedModel.macAddress,
        '00:00:00:00:00:00',
      ); // Should remain unchanged
    });

    test('should support toString method', () {
      // Arrange
      final model = FlockScanModel(
        proximityUUID: 'test-uuid',
        rssi: -50,
        accuracy: 1.0,
        proximity: Proximity.immediate,
        major: 1,
        minor: 1,
        macAddress: '00:00:00:00:00:00',
        timestamp: DateTime.now(),
      );

      // Act
      final stringRepresentation = model.toString();

      // Assert
      expect(stringRepresentation, contains('test-uuid'));
      expect(stringRepresentation, contains('-50'));
      expect(stringRepresentation, contains('1.0'));
      expect(stringRepresentation, contains('immediate'));
      expect(stringRepresentation, contains('1'));
      expect(stringRepresentation, contains('00:00:00:00:00:00'));
    });
  });
}
