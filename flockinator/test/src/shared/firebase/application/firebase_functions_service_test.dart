import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flockinator/src/shared/firebase/application/firebase_functions_service.dart';
import 'package:flockinator/src/shared/firebase/data/firebase_functions_repository.dart';

import 'firebase_functions_service_test.mocks.dart';

@GenerateMocks([FirebaseFunctionsRepository])
void main() {
  group('FirebaseFunctionsService', () {
    late FirebaseFunctionsService service;
    late MockFirebaseFunctionsRepository mockRepository;

    setUp(() {
      mockRepository = MockFirebaseFunctionsRepository();
      service = FirebaseFunctionsService(mockRepository);
    });

    group('deactivateElementByGuid', () {
      test('should return true when repository returns true', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.deactivateElementByGuid(guid),
        ).thenAnswer((_) async => true);

        // Act
        final result = await service.deactivateElementByGuid(guid);

        // Assert
        expect(result, true);
        verify(mockRepository.deactivateElementByGuid(guid)).called(1);
      });

      test('should return false when repository returns false', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.deactivateElementByGuid(guid),
        ).thenAnswer((_) async => false);

        // Act
        final result = await service.deactivateElementByGuid(guid);

        // Assert
        expect(result, false);
        verify(mockRepository.deactivateElementByGuid(guid)).called(1);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.deactivateElementByGuid(guid),
        ).thenThrow(Exception('Firebase error'));

        // Act & Assert
        expect(
          () => service.deactivateElementByGuid(guid),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.deactivateElementByGuid(guid)).called(1);
      });
    });

    group('activateElementByGuid', () {
      test('should return true when repository returns true', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.activateElementByGuid(guid),
        ).thenAnswer((_) async => true);

        // Act
        final result = await service.activateElementByGuid(guid);

        // Assert
        expect(result, true);
        verify(mockRepository.activateElementByGuid(guid)).called(1);
      });

      test('should return false when repository returns false', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.activateElementByGuid(guid),
        ).thenAnswer((_) async => false);

        // Act
        final result = await service.activateElementByGuid(guid);

        // Assert
        expect(result, false);
        verify(mockRepository.activateElementByGuid(guid)).called(1);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.activateElementByGuid(guid),
        ).thenThrow(Exception('Firebase error'));

        // Act & Assert
        expect(
          () => service.activateElementByGuid(guid),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.activateElementByGuid(guid)).called(1);
      });
    });

    group('checkElementActiveStatus', () {
      test('should return true when repository returns true', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.checkElementActiveStatus(guid),
        ).thenAnswer((_) async => true);

        // Act
        final result = await service.checkElementActiveStatus(guid);

        // Assert
        expect(result, true);
        verify(mockRepository.checkElementActiveStatus(guid)).called(1);
      });

      test('should return false when repository returns false', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.checkElementActiveStatus(guid),
        ).thenAnswer((_) async => false);

        // Act
        final result = await service.checkElementActiveStatus(guid);

        // Assert
        expect(result, false);
        verify(mockRepository.checkElementActiveStatus(guid)).called(1);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        const guid = 'test-guid';
        when(
          mockRepository.checkElementActiveStatus(guid),
        ).thenThrow(Exception('Firebase error'));

        // Act & Assert
        expect(
          () => service.checkElementActiveStatus(guid),
          throwsA(isA<Exception>()),
        );
        verify(mockRepository.checkElementActiveStatus(guid)).called(1);
      });
    });
  });
}
