import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortunes/src/features/fortunes/application/fortune_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Fortune extends ConsumerWidget {
  const Fortune({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String fortune = ref.watch(fortuneServiceProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double horizontalMargins = constraints.maxWidth * .1;
        final double verticalMargins = constraints.maxWidth * .12;
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargins,
            vertical: verticalMargins,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: constraints.maxWidth * .6,
                child: Image.asset(
                  'assets/images/your_flutter_fortune.png',
                  fit: BoxFit.fill,
                ),
              ),
              AutoSizeText(
                fortune,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}
