import 'package:flutter/material.dart';
import 'package:flutter_template/src/core/utils/logger.dart';
import 'package:flutter_template/src/core/utils/theme_provider.dart';
import 'package:flutter_template/src/features/settings/data/settings_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreenController {
  SettingsScreenController({required this.ref});

  final Ref ref;

  void switchTheme(ThemeMode thememode) {
    ref.read(themeModeProvider.notifier).state = thememode;
    ref.read(settingsRepositoryProvider.notifier).saveThemeEnum(thememode);
    ref.read(loggerProvider).i('Switched theme');
  }

  void changeLanguage(String localizationCode) {
    ref
        .read(settingsRepositoryProvider.notifier)
        .saveLocalizationCountryCode(localizationCode);
    ref.read(loggerProvider).i('Changed Language');
  }
}

final settingsScreenControllerProvider =
    Provider.autoDispose<SettingsScreenController>(
  (ref) {
    return SettingsScreenController(
      ref: ref,
    );
  },
);
