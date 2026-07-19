import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'features/navigation/presentation/main_navigation_page.dart';
import 'shared/presentation/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  runApp(
    LiquidGlassWidgets.wrap(
      adaptiveQuality: true,
      child: ProviderScope(
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
      debugShowCheckedModeBanner: false,
      title: 'comics',
      theme: AppTheme.system(),
      home: const MainNavigationPage(),
    );
  }
}
