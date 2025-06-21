import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flockinator/src/features/softprompt/presentation/softprompt_controller.dart';
import 'package:flockinator/src/shared/permissions/application/permissions_service.dart';

import 'softprompt_controller_test.mocks.dart';

@GenerateMocks([PermissionsService])
void main() {
  group('SoftPromptController', () {
    late SoftPromptController controller;
    late MockPermissionsService mockPermissionsService;

    setUp(() {
      mockPermissionsService = MockPermissionsService();
      controller = SoftPromptController(mockPermissionsService);
    });

    group('requestPermissions', () {
      test('should return true when both permissions are granted', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenAnswer((_) async => true);
        when(
          mockPermissionsService.requestLocationPermission(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.requestPermissions();

        // Assert
        expect(result, true);
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verify(mockPermissionsService.requestLocationPermission()).called(1);
      });

      test('should return false when bluetooth permission is denied', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenAnswer((_) async => false);
        when(
          mockPermissionsService.requestLocationPermission(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.requestPermissions();

        // Assert
        expect(result, false);
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verify(mockPermissionsService.requestLocationPermission()).called(1);
      });

      test('should return false when location permission is denied', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenAnswer((_) async => true);
        when(
          mockPermissionsService.requestLocationPermission(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.requestPermissions();

        // Assert
        expect(result, false);
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verify(mockPermissionsService.requestLocationPermission()).called(1);
      });

      test('should return false when both permissions are denied', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenAnswer((_) async => false);
        when(
          mockPermissionsService.requestLocationPermission(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.requestPermissions();

        // Assert
        expect(result, false);
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verify(mockPermissionsService.requestLocationPermission()).called(1);
      });

      test('should propagate exceptions from permissions service', () async {
        // Arrange
        when(
          mockPermissionsService.requestBluetoothPermission(),
        ).thenThrow(Exception('Permission error'));

        // Act & Assert
        expect(
          () => controller.requestPermissions(),
          throwsA(isA<Exception>()),
        );
        verify(mockPermissionsService.requestBluetoothPermission()).called(1);
        verifyNever(mockPermissionsService.requestLocationPermission());
      });
    });

    group('isBluetoothGranted', () {
      test('should return true when bluetooth permission is granted', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.isBluetoothGranted();

        // Assert
        expect(result, true);
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
      });

      test('should return false when bluetooth permission is denied', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.isBluetoothGranted();

        // Assert
        expect(result, false);
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
      });

      test('should propagate exceptions from permissions service', () async {
        // Arrange
        when(
          mockPermissionsService.isBluetoothGranted(),
        ).thenThrow(Exception('Permission check error'));

        // Act & Assert
        expect(
          () => controller.isBluetoothGranted(),
          throwsA(isA<Exception>()),
        );
        verify(mockPermissionsService.isBluetoothGranted()).called(1);
      });
    });
  });
}
