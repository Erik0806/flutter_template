import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Provider for an instances of SharedPreferences
///Must be overridden in ProviderScope to be used (normally at app startup)
///If not throws an UmimplementedError
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
