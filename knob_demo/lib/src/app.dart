import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knob_demo/src/serial_port/application/serial_port_service.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String yPosition =
        ref.watch(serialPortServiceProvider).valueOrNull ?? '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            _Background(),
            _Dash(yPosition: double.tryParse(yPosition) ?? 0),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/background.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class _Dash extends StatelessWidget {
  final double yPosition;

  const _Dash({this.yPosition = 50.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashHeight = constraints.maxHeight * 0.15;
        final halfDashHeight = dashHeight / 2;

        // Calculate the range for alignment values to keep Dash on screen
        final topAlignment =
            -1.0 + (halfDashHeight / (constraints.maxHeight / 2));
        final bottomAlignment =
            1.0 - (halfDashHeight / (constraints.maxHeight / 2));

        final alignmentY =
            topAlignment +
            (yPosition / 100.0) * (bottomAlignment - topAlignment);

        return Align(
          alignment: Alignment(0, alignmentY),

          child: SizedBox(
            height: dashHeight,
            child: Image.asset('assets/images/dash.png'),
          ),
        );
      },
    );
  }
}
