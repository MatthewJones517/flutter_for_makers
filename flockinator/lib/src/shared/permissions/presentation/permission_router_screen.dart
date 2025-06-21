import 'package:flockinator/src/shared/permissions/presentation/permission_router_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PermissionRouterScreen extends ConsumerStatefulWidget {
  const PermissionRouterScreen({super.key});

  @override
  ConsumerState<PermissionRouterScreen> createState() =>
      _PermissionRouterScreenState();
}

class _PermissionRouterScreenState
    extends ConsumerState<PermissionRouterScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissionsAndRoute();
  }

  Future<void> _checkPermissionsAndRoute() async {
    final controller = ref.read(permissionRouterControllerProvider);

    final arePermissionsGranted = await controller.arePermissionsGranted();

    if (mounted) {
      if (arePermissionsGranted) {
        context.go('/flock-scan');
      } else {
        context.go('/softprompt');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
