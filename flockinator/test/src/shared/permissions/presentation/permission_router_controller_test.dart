import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flockinator/src/shared/permissions/presentation/permission_router_controller.dart';
import 'package:flockinator/src/shared/permissions/application/permissions_service.dart';

import 'permission_router_controller_test.mocks.dart';

@GenerateMocks([PermissionsService])
void main() {
  group('PermissionRouterController', () {
    late PermissionRouterController controller;
    late MockPermissionsService mockPermissionsService;

    setUp(() {
      mockPermissionsService = MockPermissionsService();
      controller = PermissionRouterController(mockPermissionsService);
    });

    group('arePermissionsGranted', () {
      test('should return true when both permissions are granted', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenAnswer((_) async => true);
        when(
          mockPermissionsService.isLocationGranted(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.arePermissionsGranted();

        // Assert
        expect(result, true);
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
        verify(mockPermissionsService.isLocationGranted()).called(1);
      });

      test('should return false when bluetooth permission is denied', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenAnswer((_) async => false);
        when(
          mockPermissionsService.isLocationGranted(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.arePermissionsGranted();

        // Assert
        expect(result, false);
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
        verify(mockPermissionsService.isLocationGranted()).called(1);
      });

      test('should return false when location permission is denied', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenAnswer((_) async => true);
        when(
          mockPermissionsService.isLocationGranted(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.arePermissionsGranted();

        // Assert
        expect(result, false);
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
        verify(mockPermissionsService.isLocationGranted()).called(1);
      });

      test('should return false when both permissions are denied', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenAnswer((_) async => false);
        when(
          mockPermissionsService.isLocationGranted(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.arePermissionsGranted();

        // Assert
        expect(result, false);
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
        verify(mockPermissionsService.isLocationGranted()).called(1);
      });

      test('should propagate exceptions from permissions service', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenThrow(Exception('Permission check error'));

        // Act & Assert
        expect(
          () => controller.arePermissionsGranted(),
          throwsA(isA<Exception>()),
        );
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
        verifyNever(mockPermissionsService.isLocationGranted());
      });
    });

    group('requestPermissions', () {
      test('should request both permissions successfully', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenAnswer((_) async => true);
        when(
          mockPermissionsService.requestLocationPermission(),
        ).thenAnswer((_) async => true);

        // Act
        await controller.requestPermissions();

        // Assert
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verify(mockPermissionsService.requestLocationPermission()).called(1);
      });

      test('should handle bluetooth permission request failure', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenThrow(Exception('Bluetooth permission error'));
        when(
          mockPermissionsService.requestLocationPermission(),
        ).thenAnswer((_) async => true);

        // Act & Assert
        expect(
          () => controller.requestPermissions(),
          throwsA(isA<Exception>()),
        );
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verifyNever(mockPermissionsService.requestLocationPermission());
      });

      test('should handle location permission request failure', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenAnswer((_) async => true);
        when(
          mockPermissionsService.requestLocationPermission(),
        ).thenThrow(Exception('Location permission error'));

        // Act & Assert
        expect(
          () => controller.requestPermissions(),
          throwsA(isA<Exception>()),
        );
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verifyNever(mockPermissionsService.requestLocationPermission());
      });
    });
  });
}
