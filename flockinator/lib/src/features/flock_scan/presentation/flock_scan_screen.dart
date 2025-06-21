import 'package:flockinator/src/features/flock_scan/domain/dash_model.dart';
import 'package:flockinator/src/features/flock_scan/presentation/dash_list_tile.dart';
import 'package:flockinator/src/features/flock_scan/presentation/drawer_menu_widget.dart';
import 'package:flockinator/src/features/flock_scan/presentation/sorted_dashes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FlockScanScreen extends ConsumerWidget {
  const FlockScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<DashModel>> sortedDashes = ref.watch(
      sortedDashesControllerProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flockinator'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              context.push('/flock-scan/qrcode');
            },
          ),
        ],
      ),
      drawer: const DrawerMenuWidget(),
      body: sortedDashes.when(
        data: (sortedDashes) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: sortedDashes
                .map(
                  (dash) => DashListTile(
                    key: ValueKey(
                      '${dash.major}-${dash.minor}',
                    ), // Stable key for smooth transitions
                    dash: dash,
                  ),
                )
                .toList(),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading dashes',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Please try again',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
