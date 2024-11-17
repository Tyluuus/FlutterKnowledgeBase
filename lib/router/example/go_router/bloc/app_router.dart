import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/screens/home_page.dart';

enum Routes {
  home,
  second,
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: Routes.home.name,
        builder: (context, state) => HomePage(
          key: state.pageKey,
        ),
      ),
    ],
  );

  static GoRouter get router => _router;
}
