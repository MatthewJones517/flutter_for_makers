import 'package:flutter_fortunes/src/features/screens/presentation/fortune/fortune_screen.dart';
import 'package:flutter_fortunes/src/features/screens/presentation/loading_screen/loading_screen.dart';
import 'package:flutter_fortunes/src/features/screens/presentation/title_screen/title_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: TitleScreen()),
    ),
    GoRoute(
      path: '/loading',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: LoadingScreen()),
    ),
    GoRoute(
      path: '/fortune',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: FortuneScreen()),
    ),
  ],
);
