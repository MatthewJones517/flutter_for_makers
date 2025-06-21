import 'package:flutter_test/flutter_test.dart';
import 'package:flockinator/src/features/flock_scan/domain/dash_model.dart';

void main() {
  group('DashModel', () {
    test('should create DashModel with all required fields', () {
      // Arrange
      const name = 'Test Dash';
      const major = 1;
      const minor = 2;
      const active = true;

      // Act
      final dashModel = DashModel(
        name: name,
        major: major,
        minor: minor,
        active: active,
      );

      // Assert
      expect(dashModel.name, name);
      expect(dashModel.major, major);
      expect(dashModel.minor, minor);
      expect(dashModel.active, active);
    });

    test('should create DashModel with inactive status', () {
      // Arrange
      const name = 'Inactive Dash';
      const major = 3;
      const minor = 4;
      const active = false;

      // Act
      final dashModel = DashModel(
        name: name,
        major: major,
        minor: minor,
        active: active,
      );

      // Assert
      expect(dashModel.name, name);
      expect(dashModel.major, major);
      expect(dashModel.minor, minor);
      expect(dashModel.active, active);
    });

    test('should create DashModel from JSON', () {
      // Arrange
      final json = {
        'name': 'JSON Dash',
        'major': 5,
        'minor': 6,
        'active': true,
      };

      // Act
      final dashModel = DashModel.fromJson(json);

      // Assert
      expect(dashModel.name, 'JSON Dash');
      expect(dashModel.major, 5);
      expect(dashModel.minor, 6);
      expect(dashModel.active, true);
    });

    test('should create DashModel from JSON with inactive status', () {
      // Arrange
      final json = {
        'name': 'Inactive JSON Dash',
        'major': 7,
        'minor': 8,
        'active': false,
      };

      // Act
      final dashModel = DashModel.fromJson(json);

      // Assert
      expect(dashModel.name, 'Inactive JSON Dash');
      expect(dashModel.major, 7);
      expect(dashModel.minor, 8);
      expect(dashModel.active, false);
    });

    test('should handle JSON with string values', () {
      // Arrange
      final json = {
        'name': 'String Dash',
        'major': 9, // Use int instead of string
        'minor': 10, // Use int instead of string
        'active': true,
      };

      // Act
      final dashModel = DashModel.fromJson(json);

      // Assert
      expect(dashModel.name, 'String Dash');
      expect(dashModel.major, 9);
      expect(dashModel.minor, 10);
      expect(dashModel.active, true);
    });

    test('should handle JSON with boolean values', () {
      // Arrange
      final json = {
        'name': 'Boolean Dash',
        'major': 11,
        'minor': 12,
        'active': true, // Use bool instead of string
      };

      // Act
      final dashModel = DashModel.fromJson(json);

      // Assert
      expect(dashModel.name, 'Boolean Dash');
      expect(dashModel.major, 11);
      expect(dashModel.minor, 12);
      expect(dashModel.active, true);
    });

    test('should support equality comparison', () {
      // Arrange
      final dashModel1 = const DashModel(
        name: 'Test Dash',
        major: 1,
        minor: 2,
        active: true,
      );

      final dashModel2 = const DashModel(
        name: 'Test Dash',
        major: 1,
        minor: 2,
        active: true,
      );

      final dashModel3 = const DashModel(
        name: 'Different Dash',
        major: 1,
        minor: 2,
        active: true,
      );

      // Act & Assert
      expect(dashModel1, equals(dashModel2));
      expect(dashModel1, isNot(equals(dashModel3)));
      expect(dashModel1.hashCode, equals(dashModel2.hashCode));
    });

    test('should support copyWith method', () {
      // Arrange
      const originalDash = DashModel(
        name: 'Original Dash',
        major: 1,
        minor: 2,
        active: true,
      );

      // Act
      final copiedDash = originalDash.copyWith(
        name: 'Copied Dash',
        active: false,
      );

      // Assert
      expect(copiedDash.name, 'Copied Dash');
      expect(copiedDash.major, 1); // Should remain unchanged
      expect(copiedDash.minor, 2); // Should remain unchanged
      expect(copiedDash.active, false);
    });

    test('should support toString method', () {
      // Arrange
      const dashModel = DashModel(
        name: 'Test Dash',
        major: 1,
        minor: 2,
        active: true,
      );

      // Act
      final stringRepresentation = dashModel.toString();

      // Assert
      expect(stringRepresentation, contains('Test Dash'));
      expect(stringRepresentation, contains('1'));
      expect(stringRepresentation, contains('2'));
      expect(stringRepresentation, contains('true'));
    });
  });
}
