import 'package:flutter/material.dart';
import 'package:flutter_template/src/core/constants/routing_keys.dart';
import 'package:flutter_template/src/features/example_feature/presentation/example_screen.dart';
import 'package:flutter_template/src/features/settings/data/settings_repository.dart';
import 'package:flutter_template/src/features/settings/presentation/settings_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///Router for the app
final router = GoRouter(
  errorBuilder: (context, state) => const Placeholder(),
  initialLocation: homeRoutingKey,
  routes: [
    GoRoute(
      path: homeRoutingKey,
      builder: (context, state) {
        return Consumer(
          builder: (context, ref, child) {
            final locale =
                ref.watch(settingsRepositoryProvider).localizationCountryCode;
            return Localizations.override(
              locale: Locale(locale),
              context: context,
              child: const ExampleScreen(),
            );
          },
        );
      },
    ),
    GoRoute(
      path: settingsRoutingKey,
      builder: (context, state) {
        return Consumer(
          builder: (context, ref, child) {
            final locale =
                ref.watch(settingsRepositoryProvider).localizationCountryCode;
            return Localizations.override(
              locale: Locale(locale),
              context: context,
              child: const SettingsScreen(),
            );
          },
        );
      },
    ),
  ],
);
