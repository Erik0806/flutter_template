import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/src/core/constants/shared_prefs_keys.dart';
import 'package:flutter_template/src/core/routing/router.dart';
import 'package:flutter_template/src/core/utils/logger.dart';
import 'package:flutter_template/src/core/utils/shared_preferences_provider.dart';
import 'package:flutter_template/src/core/utils/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  final themeMode = preferences.getInt(themeEnumPrefsKey) == 1
      ? ThemeMode.light
      : preferences.getInt(themeEnumPrefsKey) == 2
          ? ThemeMode.dark
          : ThemeMode.system;
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        themeModeProvider.overrideWith((ref) => themeMode),
      ],
      child: const TemplateMain(),
    ),
  );
}

///MaterialApp for the app
class TemplateMain extends ConsumerWidget {
  ///const Constructor for the MaterialApp
  const TemplateMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    ref.read(loggerProvider).i('Started app');
    try {
      return MaterialApp.router(
        // showSemanticsDebugger: true,
        routerConfig: router,
        title: 'Flutter Template',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('de'),
          Locale('en'),
        ],
      );
    } on Exception catch (e) {
      ref.read(loggerProvider).e(e);
      return ErrorWidget(e);
    }
  }
}
