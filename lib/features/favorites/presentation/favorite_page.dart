import 'package:cinema/features/library/data/library_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../shared/presentation/hooks/glass_large_title_hook.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../history/presentation/vod_history_page.dart';
import '../../library/presentation/vod_library_grid.dart';
final favoritesProvider = StreamProvider<List<VodItem>>((ref) {
  return ref.watch(libraryDatabaseProvider).watchFavoriteVods();
});

final vodFavoriteProvider = StreamProvider.family<bool, int>((ref, vodId) {
  return ref.watch(libraryDatabaseProvider).watchFavorite(vodId: vodId);
});

class FavoritePage extends HookConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useGlassLargeTitleController();
    final favorites = ref.watch(favoritesProvider);

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
          Semantics(
            button: true,
            label: '观看历史',
            child: GlassIconButton(
              icon: const Icon(CupertinoIcons.clock),
              useOwnLayer: true,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute<void>(
                    builder: (routeContext) => const VodHistoryPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: titleController.scrollController,
        key: const PageStorageKey<String>('favorite-scroll'),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          GlassLargeTitle(
            text: '收藏',
            controller: titleController,
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.paddingOf(context).top + 16,
              16,
              8,
            ),
          ),
          VodLibraryGrid(
            items: favorites,
            emptyIcon: CupertinoIcons.heart,
            emptyTitle: '还没有收藏',
            emptyMessage: '在影片详情页点按收藏，稍后就能从这里快速找到。',
            onRetry: () => ref.invalidate(favoritesProvider),
          ),
        ],
      ),
    );
  }
}
