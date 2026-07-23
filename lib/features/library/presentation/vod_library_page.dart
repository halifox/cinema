import 'package:cinema/features/library/application/library_providers.dart';
import 'package:cinema/shared/presentation/hooks/glass_large_title_hook.dart';
import 'package:cinema/shared/presentation/widgets/ambient_glow_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'vod_history_page.dart';
import 'vod_library_grid.dart';

class VodLibraryPage extends HookConsumerWidget {
  const VodLibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useGlassLargeTitleController();

    return GlassScaffold(
      edgeToEdge: true,
      contentAwareBrightness: true,
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      topEdgeFade: true,
      bottomEdgeFade: true,
      topEdgeFadeExtent: 64,
      bottomEdgeFadeExtent: 64,
      headerScrollController: titleController.scrollController,
      header: GlassAppBar(
        actions: [
          GlassIconButton(
            icon: const Icon(CupertinoIcons.clock),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (routeContext) => const VodHistoryPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        controller: titleController.scrollController,
        key: const PageStorageKey('library-scroll'),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          GlassLargeTitle(
            text: '片单',
            controller: titleController,
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.paddingOf(context).top + 16,
              16,
              8,
            ),
          ),
          VodLibraryGrid(
            items: ref.watch(favoritesProvider),
            emptyIcon: CupertinoIcons.rectangle_stack,
            emptyTitle: '片单还是空的',
            emptyMessage: '在影片详情页将影片加入片单，稍后就能从这里快速找到。',
            onRetry: () => ref.invalidate(favoritesProvider),
          ),
        ],
      ),
    );
  }
}
