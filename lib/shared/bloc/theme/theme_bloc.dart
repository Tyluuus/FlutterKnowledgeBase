import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base/app/example/app_constants.dart';
import 'package:knowledge_base/di/example/injector.dart';
import 'package:knowledge_base/shared/bloc/theme/theme_event.dart';
import 'package:knowledge_base/shared/bloc/theme/theme_state.dart';
import 'package:knowledge_base/shared/local/example/shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final sharedPref = injector.get<SharedPref>();

  ThemeBloc() : super(const ThemeState()) {
    on<GetCurrentThemeEvent>(_getDefaultThemeEvent);
    on<SetDarkThemeEvent>(_setDarkTheme);
    on<SetLightThemeEvent>(_setLightTheme);
    on<SetDefaultSystemThemeEvent>(_setDefaultThemeEvent);
  }

  void _setDarkTheme(SetDarkThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(currentTheme: ThemeMode.dark, selectedTheme: 'dark'));
    sharedPref.set(AppConstants.CURRENT_THEME, state.selectedTheme);
  }

  void _setLightTheme(SetLightThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(currentTheme: ThemeMode.light, selectedTheme: 'light'));
    sharedPref.set(AppConstants.CURRENT_THEME, state.selectedTheme);
  }

  void _setDefaultThemeEvent(SetDefaultSystemThemeEvent event, Emitter<ThemeState> emit) {
    sharedPref.set(AppConstants.CURRENT_THEME, 'default');
    final defaultThemeMode = WidgetsBinding.instance.window.platformBrightness;
    final value = ThemeMode.values.byName(defaultThemeMode.name);
    emit(state.copyWith(currentTheme: value, selectedTheme: 'default'));
  }

  void _getDefaultThemeEvent(GetCurrentThemeEvent event, Emitter<ThemeState> emit) async {
    final String? theme = await sharedPref.get(AppConstants.CURRENT_THEME) as String?;
    if (theme == null || theme == 'default') {
      final defaultThemeMode = WidgetsBinding.instance.window.platformBrightness;
      final value = ThemeMode.values.byName(defaultThemeMode.name);
      emit(state.copyWith(currentTheme: value, selectedTheme: 'default'));
    } else {
      final value = ThemeMode.values.byName(theme);
      emit(state.copyWith(currentTheme: value, selectedTheme: value.name));
    }
  }
}
