import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowledge_base/app/example/app_strings.dart';
import 'package:knowledge_base/app/example/app_theme.dart';
import 'package:knowledge_base/router/example/go_router/riverpod/app_router.dart';
import 'package:knowledge_base/shared/provider/example/app_theme_provider.dart';

/// We are extending Consumer Widget to be able to use Riverpod library.
/// Below we add watch for two providers: goRouter for navigation and appTheme for theme changes.
/// We also make initialization of ScreenUtil library.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(appThemeProvider);

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            title: AppStrings.appName,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            themeMode: themeMode.currentTheme,
            routerDelegate: goRouter.routerDelegate,
            routeInformationParser: goRouter.routeInformationParser,
            routeInformationProvider: goRouter.routeInformationProvider,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
