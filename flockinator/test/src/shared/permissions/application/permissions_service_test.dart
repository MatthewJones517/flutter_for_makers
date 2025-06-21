import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flockinator/src/shared/permissions/application/permissions_service.dart';
import 'package:flockinator/src/shared/permissions/data/permission_handler_repository.dart';

import 'permissions_service_test.mocks.dart';

@GenerateMocks([PermissionHandlerRepository])
void main() {
  group('PermissionsService', () {
    late PermissionsService service;
    late MockPermissionHandlerRepository mockRepository;

    setUp(() {
      mockRepository = MockPermissionHandlerRepository();
      service = PermissionsService(mockRepository);
    });

    group('isBluetoothGranted', () {
      test('should return true when repository returns true', () async {
        // Arrange
        when(mockRepository.isBluetoothGranted()).thenAnswer((_) async => true);

        // Act
        final result = await service.isBluetoothGranted();

        // Assert
        expect(result, true);
        verify(mockRepository.isBluetoothGranted()).called(1);
      });

      test('should return false when repository returns false', () async {
        // Arrange
        when(
          mockRepository.isBluetoothGranted(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await service.isBluetoothGranted();

        // Assert
        expect(result, false);
        verify(mockRepository.isBluetoothGranted()).called(1);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        when(
          mockRepository.isBluetoothGranted(),
        ).thenThrow(Exception('Permission check error'));

        // Act & Assert
        expect(() => service.isBluetoothGranted(), throwsA(isA<Exception>()));
        verify(mockRepository.isBluetoothGranted()).called(1);
      });
    });

    group('requestBluetoothPermission', () {
      test('should return true when repository returns true', () async {
        // Arrange
        when(
          mockRepository.requestBluetoothPermission(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await service.requestBluetoothPermission();

        // Assert
        expect(result, true);
        verify(mockRepository.requestBluetoothPermission()).called(1);
      });

      test('should return false when repository returns false', () async {
        // Arrange
        when(
          mockRepository.requestBluetoothPermission(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await service.requestBluetoothPermission();

        // Assert
        expect(result, false);
        verify(mockRepository.requestBluetoothPermission()).called(1);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        when(
          mockRepository.requestBluetoothPermission(),
        ).thenThrow(Exception('Permission request error'));

        // Act & Assert
        expect(
          () => service.requestBluetoothPermission(),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.requestBluetoothPermission()).called(1);
      });
    });

    group('isLocationGranted', () {
      test('should return true when repository returns true', () async {
        // Arrange
        when(mockRepository.isLocationGranted()).thenAnswer((_) async => true);

        // Act
        final result = await service.isLocationGranted();

        // Assert
        expect(result, true);
        verify(mockRepository.isLocationGranted()).called(1);
      });

      test('should return false when repository returns false', () async {
        // Arrange
        when(mockRepository.isLocationGranted()).thenAnswer((_) async => false);

        // Act
        final result = await service.isLocationGranted();

        // Assert
        expect(result, false);
        verify(mockRepository.isLocationGranted()).called(1);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        when(
          mockRepository.isLocationGranted(),
        ).thenThrow(Exception('Location permission check error'));

        // Act & Assert
        expect(() => service.isLocationGranted(), throwsA(isA<Exception>()));
        verify(mockRepository.isLocationGranted()).called(1);
      });
    });

    group('requestLocationPermission', () {
      test('should return true when repository returns true', () async {
        // Arrange
        when(
          mockRepository.requestLocationPermission(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await service.requestLocationPermission();

        // Assert
        expect(result, true);
        verify(mockRepository.requestLocationPermission()).called(1);
      });

      test('should return false when repository returns false', () async {
        // Arrange
        when(
          mockRepository.requestLocationPermission(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await service.requestLocationPermission();

        // Assert
        expect(result, false);
        verify(mockRepository.requestLocationPermission()).called(1);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        when(
          mockRepository.requestLocationPermission(),
        ).thenThrow(Exception('Location permission request error'));

        // Act & Assert
        expect(
          () => service.requestLocationPermission(),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.requestLocationPermission()).called(1);
      });
    });
  });
}
