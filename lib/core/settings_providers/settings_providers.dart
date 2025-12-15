import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_store/core/routes/app_router.dart';
import 'package:open_store/features/products/presentation/provider/cart_provider.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  static const String themeModeKey = "isDarkMode";

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final isDark = prefs.getBool(themeModeKey);

    if (isDark == null) return ThemeMode.system;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setBool(themeModeKey, isDark);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
);

class LocalNotifier extends Notifier<Locale> {
  static const String localKey = "Local";

  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final languageCode = prefs.getString(localKey);
    return Locale(languageCode ?? "en");
  }

  void setLocalLanguage(String languageCode) {
    state = Locale(languageCode);
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setString(localKey, languageCode);
  }
}

final localProvider = NotifierProvider<LocalNotifier, Locale>(
  () => LocalNotifier(),
);

final routersProvider = Provider((ref) => router);
