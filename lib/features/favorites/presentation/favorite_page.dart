import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../../shared/presentation/widgets/vod_card.dart';
import '../application/favorites_provider.dart';

class FavoritePage extends HookConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    return GlassScaffold(
      edgeToEdge: true,
      contentAwareBrightness: true,
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      topEdgeFade: true,
      bottomEdgeFade: true,
      body: CustomScrollView(
        key: const PageStorageKey<String>('favorite-scroll'),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.paddingOf(context).top + 18,
                20,
                8,
              ),
              child: Text(
                '收藏',
                style: TextStyle(
                  color: CupertinoColors.label.resolveFrom(context),
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.2,
                ),
              ),
            ),
          ),
          if (favorites.isEmpty)
            const ContentStateSliver.empty(
              icon: CupertinoIcons.heart,
              title: '还没有收藏',
              message: '在影片详情页点按收藏，稍后就能从这里快速找到。',
            )
          else
            VodGridSliver(items: favorites),
          const SliverToBoxAdapter(child: SizedBox(height: 104)),
        ],
      ),
    );
  }
}
