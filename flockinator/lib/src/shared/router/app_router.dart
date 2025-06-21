import 'package:go_router/go_router.dart';
import '../../features/softprompt/presentation/softprompt_screen.dart';
import '../../features/flock_scan/presentation/flock_scan_screen.dart';
import '../../features/claim/presentation/claim_screen.dart';
import '../../features/qr_scan/presentation/qr_scan_screen.dart';
import '../permissions/presentation/permission_router_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/permission-check',
  routes: [
    GoRoute(
      path: '/permission-check',
      name: 'permission-check',
      builder: (context, state) => const PermissionRouterScreen(),
    ),
    GoRoute(
      path: '/softprompt',
      name: 'softprompt',
      builder: (context, state) => const SoftPromptScreen(),
    ),
    GoRoute(
      path: '/flock-scan',
      name: 'flock-scan',
      builder: (context, state) => const FlockScanScreen(),
    ),
    GoRoute(
      path: '/flock-scan/qrcode',
      name: 'qr-scan',
      builder: (context, state) => const QrScanScreen(),
    ),
    GoRoute(
      path: '/flock-scan/claim/:dashGuid',
      name: 'claim',
      builder: (context, state) {
        final dashGuid = state.pathParameters['dashGuid']!;
        return ClaimScreen(dashGuid: dashGuid);
      },
    ),
  ],
);
