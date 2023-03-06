import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/src/core/utils/logger.dart';
import 'package:flutter_template/src/features/settings/data/settings_repository.dart';
import 'package:flutter_template/src/features/settings/presentation/settings_screen_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(loggerProvider).i('Built settingsScreen');
    final state = ref.watch(settingsRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.arrow_back,
              size: 32,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.themeMode),
                  trailing: ToggleSwitch(
                    animate: true,
                    curve: Curves.bounceInOut,
                    cornerRadius: 20,
                    initialLabelIndex: state.themeMode == ThemeMode.system
                        ? 0
                        : state.themeMode == ThemeMode.light
                            ? 1
                            : 2,
                    totalSwitches: 3,
                    labels: [
                      AppLocalizations.of(context)!.system,
                      AppLocalizations.of(context)!.light,
                      AppLocalizations.of(context)!.dark,
                    ],
                    onToggle: (index) {
                      var themeMode = ThemeMode.system;
                      switch (index) {
                        case 0:
                          themeMode = ThemeMode.system;
                          break;
                        case 1:
                          themeMode = ThemeMode.light;
                          break;
                        case 2:
                          themeMode = ThemeMode.dark;
                          break;
                      }
                      ref
                          .read(settingsScreenControllerProvider)
                          .switchTheme(themeMode);
                    },
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.language),
                  trailing: ToggleSwitch(
                    animate: true,
                    curve: Curves.bounceInOut,
                    cornerRadius: 20,
                    initialLabelIndex:
                        state.localizationCountryCode == 'de' ? 0 : 1,
                    totalSwitches: 2,
                    minWidth: 110,
                    labels: [
                      AppLocalizations.of(context)!.german,
                      AppLocalizations.of(context)!.english,
                    ],
                    onToggle: (index) {
                      var countryCode = 'de';
                      if (index == 1) {
                        countryCode = 'en';
                      }
                      ref.read(settingsScreenControllerProvider).changeLanguage(
                            countryCode,
                          );
                    },
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.debugScreen),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // ignore: inference_failure_on_function_invocation
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Card(
                              color: Colors.black,
                              child: LogConsoleWidget(
                                logConsoleManager:
                                    ref.read(logConsoleManagerProvider),
                                theme:
                                    LogConsoleTheme.byTheme(Theme.of(context)),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.debugScreen),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          // TODO(Erik0806): update,
          const Text('Version 0.0.1 - © Erik Dierkes: 02.2023'),
        ],
      ),
    );
  }
}
