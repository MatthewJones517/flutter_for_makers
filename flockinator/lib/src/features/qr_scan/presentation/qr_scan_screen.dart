import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';

class QrScanScreen extends StatelessWidget {
  const QrScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Dash QR Code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: MobileScanner(
        onDetect: (result) {
          final rawValue = result.barcodes.first.rawValue;

          if (rawValue != null &&
              rawValue.startsWith(
                'https://flockinator.makerinator.com/flock-scan/claim/',
              )) {
            // Extract the GUID from the URL
            final dashGuid = rawValue.substring(
              'https://flockinator.makerinator.com/flock-scan/claim/'.length,
            );

            // Navigate to the claim screen with the extracted GUID
            context.go('/flock-scan/claim/$dashGuid');
          }
        },
      ),
    );
  }
}
