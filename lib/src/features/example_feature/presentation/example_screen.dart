import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/src/core/constants/routing_keys.dart';
import 'package:flutter_template/src/core/utils/logger.dart';
import 'package:flutter_template/src/features/settings/data/settings_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///Example Screen for Example App
class ExampleScreen extends ConsumerWidget {
  ///Lame constructor
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsRepositoryProvider);
    ref.read(loggerProvider).i('Built activeNotifiesScreen');
    return Localizations.override(
      context: context,
      locale: Locale(settings.localizationCountryCode),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(AppLocalizations.of(context)!.forFrodo)),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    size: 32,
                  ),
                  title: Text(AppLocalizations.of(context)!.settings),
                  onTap: () {
                    context
                      ..pop()
                      ..push(settingsRoutingKey);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
