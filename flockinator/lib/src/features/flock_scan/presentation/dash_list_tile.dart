import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import 'package:flockinator/src/features/flock_scan/domain/flock_scan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flockinator/src/features/flock_scan/application/flock_scan_service.dart';
import 'package:flockinator/src/features/flock_scan/domain/dash_model.dart';

class DashListTile extends ConsumerWidget {
  final DashModel dash;

  const DashListTile({super.key, required this.dash});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FlockScanModel? flockScanService = ref.watch(
      flockScanServiceProvider(major: dash.major, minor: dash.minor),
    );

    String statusText;
    String imagePath;

    if (!dash.active) {
      statusText = "Dash Claimed!";
      imagePath = 'assets/images/claimed.png';
    } else if (flockScanService == null) {
      statusText = "The Skies are Clear...";
      imagePath = Theme.of(context).brightness == Brightness.dark
          ? 'assets/images/out-of-range-dark.png'
          : 'assets/images/out-of-range-light.png';
    } else {
      switch (flockScanService.proximity) {
        case Proximity.unknown:
        case Proximity.far:
          statusText = "You Hear a Distant Flutter...";
          imagePath = 'assets/images/in-range.png';
          break;
        case Proximity.near:
          statusText = "The Chirping is Getting Louder!";
          imagePath = 'assets/images/nearby.png';
          break;
        case Proximity.immediate:
          statusText = "She's right under your beak!";
          imagePath = 'assets/images/immediate.png';
          break;
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          // Add subtle border for better contrast in dark mode
          border: Theme.of(context).brightness == Brightness.dark
              ? Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.signal_wifi_off,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurfaceVariant
                          : Colors.grey,
                      size: 40,
                    ),
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dash.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(context, statusText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context, String statusText) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (statusText) {
      case "She's right under your beak!":
        return isDark ? Colors.red[400]! : Colors.red[600]!;
      case "You Hear a Distant Flutter...":
        return isDark ? Colors.blue[400]! : Colors.blue[600]!;
      case "The Chirping is Getting Louder!":
        return isDark ? Colors.green[400]! : Colors.green[600]!;
      case "The Skies are Clear...":
      case "Dash Claimed!":
        return isDark ? Colors.grey[400]! : Colors.grey[600]!;
      default:
        return isDark ? Colors.grey[400]! : Colors.grey[600]!;
    }
  }
}
