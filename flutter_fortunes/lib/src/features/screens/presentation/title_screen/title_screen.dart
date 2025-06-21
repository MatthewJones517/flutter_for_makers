import 'package:flutter/material.dart';
import 'package:flutter_fortunes/src/shared/serial_port/application/serial_port_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TitleScreen extends ConsumerWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(serialPortServiceProvider, (previous, next) {
      next.whenData((data) {
        if (data.contains('ACTIVATE')) {
          context.go('/loading');
        }
      });
    });

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          context.go('/loading');
        },
        child: Image.asset(
          'assets/images/title.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
