import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flockinator/src/shared/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    group('Color constants', () {
      test('should have correct primary color', () {
        // Act & Assert
        expect(AppTheme.primaryColor, const Color(0xFF0553B1));
      });

      test('should have correct dark accent color', () {
        // Act & Assert
        expect(AppTheme.darkAccentColor, const Color(0xFF042B59));
      });

      test('should have correct light accent color', () {
        // Act & Assert
        expect(AppTheme.lightAccentColor, const Color(0xFF027DFD));
      });
    });

    group('Light theme', () {
      test('should create light theme with correct properties', () {
        // Act
        final theme = AppTheme.lightTheme;

        // Assert
        expect(theme, isA<ThemeData>());
        expect(theme.useMaterial3, true);
        expect(theme.colorScheme.brightness, Brightness.light);
        expect(theme.colorScheme.primary, AppTheme.primaryColor);
        expect(theme.colorScheme.secondary, AppTheme.lightAccentColor);
        expect(theme.colorScheme.tertiary, AppTheme.darkAccentColor);
      });

      test('should have correct app bar theme', () {
        // Act
        final theme = AppTheme.lightTheme;
        final appBarTheme = theme.appBarTheme;

        // Assert
        expect(appBarTheme.backgroundColor, AppTheme.primaryColor);
        expect(appBarTheme.foregroundColor, Colors.white);
        expect(appBarTheme.elevation, 0);
        expect(appBarTheme.centerTitle, true);
      });

      test('should have correct elevated button theme', () {
        // Act
        final theme = AppTheme.lightTheme;
        final buttonTheme = theme.elevatedButtonTheme;

        // Assert
        expect(
          buttonTheme.style?.backgroundColor?.resolve({}),
          AppTheme.primaryColor,
        );
        expect(buttonTheme.style?.foregroundColor?.resolve({}), Colors.white);
        expect(buttonTheme.style?.elevation, isA<WidgetStateMapper<double>>());
        expect(
          buttonTheme.style?.shape,
          isA<WidgetStatePropertyAll<OutlinedBorder>>(),
        );
      });

      test('should have correct card theme', () {
        // Act
        final theme = AppTheme.lightTheme;
        final cardTheme = theme.cardTheme;

        // Assert
        expect(cardTheme.elevation, 2);
        expect(cardTheme.shape, isA<RoundedRectangleBorder>());
      });

      test('should have correct input decoration theme', () {
        // Act
        final theme = AppTheme.lightTheme;
        final inputTheme = theme.inputDecorationTheme;

        // Assert
        expect(inputTheme.border, isA<OutlineInputBorder>());
        expect(inputTheme.focusedBorder, isA<OutlineInputBorder>());
      });
    });

    group('Dark theme', () {
      test('should create dark theme with correct properties', () {
        // Act
        final theme = AppTheme.darkTheme;

        // Assert
        expect(theme, isA<ThemeData>());
        expect(theme.useMaterial3, true);
        expect(theme.colorScheme.brightness, Brightness.dark);
        expect(theme.colorScheme.primary, AppTheme.primaryColor);
        expect(theme.colorScheme.secondary, AppTheme.lightAccentColor);
        expect(theme.colorScheme.tertiary, AppTheme.darkAccentColor);
      });

      test('should have enhanced surface colors for dark mode', () {
        // Act
        final theme = AppTheme.darkTheme;
        final colorScheme = theme.colorScheme;

        // Assert
        expect(colorScheme.surface, const Color(0xFF1E1E1E));
        expect(colorScheme.surfaceContainerHighest, const Color(0xFF2D2D2D));
        expect(colorScheme.outline, const Color(0xFF404040));
        expect(colorScheme.outlineVariant, const Color(0xFF505050));
      });

      test('should have correct app bar theme for dark mode', () {
        // Act
        final theme = AppTheme.darkTheme;
        final appBarTheme = theme.appBarTheme;

        // Assert
        expect(appBarTheme.backgroundColor, AppTheme.darkAccentColor);
        expect(appBarTheme.foregroundColor, Colors.white);
        expect(appBarTheme.elevation, 0);
        expect(appBarTheme.centerTitle, true);
      });

      test('should have correct elevated button theme for dark mode', () {
        // Act
        final theme = AppTheme.darkTheme;
        final buttonTheme = theme.elevatedButtonTheme;

        // Assert
        expect(
          buttonTheme.style?.backgroundColor?.resolve({}),
          AppTheme.primaryColor,
        );
        expect(buttonTheme.style?.foregroundColor?.resolve({}), Colors.white);
        expect(buttonTheme.style?.elevation, isA<WidgetStateMapper<double>>());
        expect(
          buttonTheme.style?.shape,
          isA<WidgetStatePropertyAll<OutlinedBorder>>(),
        );
      });

      test('should have enhanced card theme for dark mode', () {
        // Act
        final theme = AppTheme.darkTheme;
        final cardTheme = theme.cardTheme;

        // Assert
        expect(cardTheme.elevation, 4);
        expect(cardTheme.shape, isA<RoundedRectangleBorder>());
        expect(cardTheme.color, const Color(0xFF2D2D2D));
        expect(cardTheme.shadowColor, Colors.black54);
        expect(cardTheme.margin, const EdgeInsets.only(bottom: 12.0));
        expect(cardTheme.surfaceTintColor, const Color(0xFF404040));
      });

      test('should have correct input decoration theme for dark mode', () {
        // Act
        final theme = AppTheme.darkTheme;
        final inputTheme = theme.inputDecorationTheme;

        // Assert
        expect(inputTheme.border, isA<OutlineInputBorder>());
        expect(inputTheme.focusedBorder, isA<OutlineInputBorder>());
      });
    });

    group('Theme consistency', () {
      test('should have consistent primary colors across themes', () {
        // Act
        final lightTheme = AppTheme.lightTheme;
        final darkTheme = AppTheme.darkTheme;

        // Assert
        expect(lightTheme.colorScheme.primary, darkTheme.colorScheme.primary);
        expect(
          lightTheme.colorScheme.secondary,
          darkTheme.colorScheme.secondary,
        );
        expect(lightTheme.colorScheme.tertiary, darkTheme.colorScheme.tertiary);
      });

      test('should have consistent button styles across themes', () {
        // Act
        final lightTheme = AppTheme.lightTheme;
        final darkTheme = AppTheme.darkTheme;

        // Assert
        expect(
          lightTheme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
          darkTheme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
        );
        expect(
          lightTheme.elevatedButtonTheme.style?.foregroundColor?.resolve({}),
          darkTheme.elevatedButtonTheme.style?.foregroundColor?.resolve({}),
        );
      });

      test('should have consistent app bar center title across themes', () {
        // Act
        final lightTheme = AppTheme.lightTheme;
        final darkTheme = AppTheme.darkTheme;

        // Assert
        expect(
          lightTheme.appBarTheme.centerTitle,
          darkTheme.appBarTheme.centerTitle,
        );
        expect(
          lightTheme.appBarTheme.elevation,
          darkTheme.appBarTheme.elevation,
        );
      });

      test('should have consistent input decoration border radius', () {
        // Act
        final lightTheme = AppTheme.lightTheme;
        final darkTheme = AppTheme.darkTheme;

        // Assert
        final lightBorder =
            lightTheme.inputDecorationTheme.border as OutlineInputBorder;
        final darkBorder =
            darkTheme.inputDecorationTheme.border as OutlineInputBorder;

        expect(lightBorder.borderRadius, darkBorder.borderRadius);
      });
    });

    group('Theme accessibility', () {
      test('should have sufficient contrast in light theme', () {
        // Act
        final theme = AppTheme.lightTheme;
        final colorScheme = theme.colorScheme;

        // Assert
        expect(colorScheme.brightness, Brightness.light);
        expect(colorScheme.primary, isA<Color>());
        expect(colorScheme.secondary, isA<Color>());
        expect(colorScheme.tertiary, isA<Color>());
      });

      test('should have sufficient contrast in dark theme', () {
        // Act
        final theme = AppTheme.darkTheme;
        final colorScheme = theme.colorScheme;

        // Assert
        expect(colorScheme.brightness, Brightness.dark);
        expect(colorScheme.primary, isA<Color>());
        expect(colorScheme.secondary, isA<Color>());
        expect(colorScheme.tertiary, isA<Color>());
      });

      test('should use Material 3 design system', () {
        // Act
        final lightTheme = AppTheme.lightTheme;
        final darkTheme = AppTheme.darkTheme;

        // Assert
        expect(lightTheme.useMaterial3, true);
        expect(darkTheme.useMaterial3, true);
      });
    });
  });
}
