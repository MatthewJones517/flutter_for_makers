import 'package:flutter/material.dart';
import 'package:flutter_fortunes/src/features/screens/presentation/fortune/fortune.dart';
import 'package:flutter_fortunes/src/shared/serial_port/application/serial_port_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FortuneScreen extends ConsumerWidget {
  const FortuneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _navigateAfterDelay(context, ref);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Image.asset(
            'assets/images/fortune_frame.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Fortune(),
        ],
      ),
    );
  }

  void _navigateAfterDelay(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 7), () {
      if (!context.mounted) return;

      ref.read(serialPortServiceProvider.notifier).writeString('DEACTIVATE');

      context.go('/'); // Perform navigation
    });
  }
}
