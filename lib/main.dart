import 'package:cinema/cms/cms_vod_repository.dart';
import 'package:cinema/features/navigation/presentation/main_navigation_page.dart';
import 'package:cinema/features/vod/domain/vod_repository.dart';
import 'package:cinema/shared/application/shared_preferences_provider.dart';
import 'package:cinema/shared/presentation/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:media_kit/media_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    LiquidGlassWidgets.wrap(
      adaptiveQuality: true,
      child: ProviderScope(
        overrides: [
          vodRepositoryProvider.overrideWith(
            (ref) => ref.watch(cmsVodRepositoryProvider),
          ),
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        retry: (retryCount, error) => null,
        child: const CinemaApp(),
      ),
    ),
  );
}

class CinemaApp extends HookConsumerWidget {
  const CinemaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp(
      theme: AppTheme.system(),
      home: const MainNavigationPage(),
    );
  }
}
