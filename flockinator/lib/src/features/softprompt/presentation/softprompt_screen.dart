import 'package:flockinator/src/features/softprompt/presentation/softprompt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/app_theme.dart';

class SoftPromptScreen extends ConsumerWidget {
  const SoftPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flockinator Permissions'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dynamic logo based on theme mode
              Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/flockinator-dark.png'
                    : 'assets/images/flockinator-light.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              // Welcome text with theme-aware color
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Welcome to Flockinator!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF87CEEB) // Sky blue for dark mode
                        : AppTheme.darkAccentColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "Dash needs to sniff the air for hidden friends. Can we turn on Bluetooth and access your location so she can find her flock?\n\nYour location data will be used to help you find the Dash's hidden around the conference. Anonymized data may also be sent to Firebase crashlytics to track performance. Otherwise your data is not retained and will never be sold to third parties.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 32.0,
                  left: 24,
                  right: 24,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      final controller = ref.read(softPromptControllerProvider);
                      final granted = await controller.requestPermissions();
                      if (granted) {
                        if (context.mounted) {
                          context.go('/flock-scan');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
