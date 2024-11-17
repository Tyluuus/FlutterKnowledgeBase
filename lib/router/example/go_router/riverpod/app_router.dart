import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum Routes {
  home,
  secondScreen,
  thirdScreen,
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: [
      // GoRoute(
      //   path: '/',
      //   name: Routes.home.name,
      //   builder: (context, state) => HomePage(
      //     key: state.pageKey,
      //   ),
      // ),
      // GoRoute(
      //     path: '/secondScreen',
      //     name: Routes.secondScreen.name,
      //     builder: (context, state) => SecondScreen(
      //         key: state.pageKey),),
    ],
  );
}
