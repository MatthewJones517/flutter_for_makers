import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flockinator/src/features/claim/presentation/claim_controller.dart';
import 'package:flockinator/src/shared/firebase/application/firebase_functions_service.dart';

import 'claim_controller_test.mocks.dart';

@GenerateMocks([FirebaseFunctionsService])
void main() {
  group('ClaimController', () {
    late ClaimController controller;
    late MockFirebaseFunctionsService mockFirebaseFunctionsService;

    setUp(() {
      mockFirebaseFunctionsService = MockFirebaseFunctionsService();
      controller = ClaimController(mockFirebaseFunctionsService);
    });

    group('deactivateElementByGuid', () {
      test('should return true when Firebase service returns true', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.deactivateElementByGuid(guid),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.deactivateElementByGuid(guid);

        // Assert
        expect(result, true);
        verify(
          mockFirebaseFunctionsService.deactivateElementByGuid(guid),
        ).called(1);
      });

      test('should return false when Firebase service returns false', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.deactivateElementByGuid(guid),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.deactivateElementByGuid(guid);

        // Assert
        expect(result, false);
        verify(
          mockFirebaseFunctionsService.deactivateElementByGuid(guid),
        ).called(1);
      });

      test('should propagate exceptions from Firebase service', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.deactivateElementByGuid(guid),
        ).thenThrow(Exception('Firebase error'));

        // Act & Assert
        expect(
          () => controller.deactivateElementByGuid(guid),
          throwsA(isA<Exception>()),
        );
        verify(
          mockFirebaseFunctionsService.deactivateElementByGuid(guid),
        ).called(1);
      });
    });

    group('activateElementByGuid', () {
      test('should return true when Firebase service returns true', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.activateElementByGuid(guid),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.activateElementByGuid(guid);

        // Assert
        expect(result, true);
        verify(
          mockFirebaseFunctionsService.activateElementByGuid(guid),
        ).called(1);
      });

      test('should return false when Firebase service returns false', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.activateElementByGuid(guid),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.activateElementByGuid(guid);

        // Assert
        expect(result, false);
        verify(
          mockFirebaseFunctionsService.activateElementByGuid(guid),
        ).called(1);
      });

      test('should propagate exceptions from Firebase service', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.activateElementByGuid(guid),
        ).thenThrow(Exception('Firebase error'));

        // Act & Assert
        expect(
          () => controller.activateElementByGuid(guid),
          throwsA(isA<Exception>()),
        );
        verify(
          mockFirebaseFunctionsService.activateElementByGuid(guid),
        ).called(1);
      });
    });

    group('checkElementActiveStatus', () {
      test('should return true when Firebase service returns true', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.checkElementActiveStatus(guid),
        ).thenAnswer((_) async => true);

        // Act
        final result = await controller.checkElementActiveStatus(guid);

        // Assert
        expect(result, true);
        verify(
          mockFirebaseFunctionsService.checkElementActiveStatus(guid),
        ).called(1);
      });

      test('should return false when Firebase service returns false', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.checkElementActiveStatus(guid),
        ).thenAnswer((_) async => false);

        // Act
        final result = await controller.checkElementActiveStatus(guid);

        // Assert
        expect(result, false);
        verify(
          mockFirebaseFunctionsService.checkElementActiveStatus(guid),
        ).called(1);
      });

      test('should propagate exceptions from Firebase service', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockFirebaseFunctionsService.checkElementActiveStatus(guid),
        ).thenThrow(Exception('Firebase error'));

        // Act & Assert
        expect(
          () => controller.checkElementActiveStatus(guid),
          throwsA(isA<Exception>()),
        );
        verify(
          mockFirebaseFunctionsService.checkElementActiveStatus(guid),
        ).called(1);
      });
    });
  });
}
