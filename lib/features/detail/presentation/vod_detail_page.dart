import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/cached_image_feedback.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../favorites/application/favorites_provider.dart';
import '../../player/presentation/player_page.dart';

class VodDetailPage extends HookConsumerWidget {
  const VodDetailPage({
    required this.vodId,
    required this.initialItem,
    super.key,
  });

  final int vodId;
  final VodItem initialItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(vodDetailProvider(vodId));
    final item = detail.value ?? initialItem;
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((favorite) => favorite.id == vodId);
    final sources = parsePlaySources(
      playFrom: item.playFrom,
      playUrl: item.playUrl,
    );

    return GlassScaffold(
      edgeToEdge: true,
      contentAwareBrightness: true,
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      appBar: GlassAppBar(
        leading: GlassIconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          useOwnLayer: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          GlassIconButton(
            icon: Icon(
              isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            ),
            useOwnLayer: true,
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggle(item: item),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
              child: Hero(
                tag: 'vod-cover-${item.id}',
                child: item.picture.isEmpty
                    ? buildCachedImageError(context, '', StateError('empty'))
                    : CachedNetworkImage(
                        imageUrl: item.picture,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        progressIndicatorBuilder: buildCachedImageLoading,
                        errorWidget: buildCachedImageError,
                      ),
              ),
            ),
          ),
          if (detail.isLoading && item.playUrl.isEmpty)
            const ContentLoadingSliver()
          else if (detail.hasError && item.playUrl.isEmpty)
            ContentErrorSliver(
              error: detail.error!,
              onRetry: () => ref.invalidate(vodDetailProvider(vodId)),
            )
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.16,
                        letterSpacing: -.7,
                      ),
                    ),
                    if (item.remarks.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        item.remarks,
                        style: TextStyle(
                          color: CupertinoTheme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: buildMetadataChips(item: item),
                    ),
                    if (item.actor.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      DetailTextBlock(title: '主演', text: item.actor),
                    ],
                    if (item.director.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      DetailTextBlock(title: '导演', text: item.director),
                    ],
                    if (item.summary.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      GlassCard(
                        child: DetailTextBlock(title: '简介', text: item.summary),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Text(
                      '选集播放',
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (sources.isEmpty)
                      Text(
                        '暂无可播放线路',
                        style: TextStyle(
                          color: CupertinoColors.secondaryLabel.resolveFrom(
                            context,
                          ),
                        ),
                      )
                    else
                      for (final source in sources) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 10),
                          child: Text(
                            source.name,
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel.resolveFrom(
                                context,
                              ),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final episode in source.episodes)
                              GlassChip(
                                icon: const Icon(CupertinoIcons.play_fill),
                                label: episode.name,
                                onTap: () => openEpisode(
                                  context: context,
                                  item: item,
                                  source: source,
                                  episode: episode,
                                ),
                              ),
                          ],
                        ),
                      ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

List<Widget> buildMetadataChips({required VodItem item}) {
  return [
    if (item.year.isNotEmpty)
      GlassChip(
        icon: const Icon(CupertinoIcons.calendar),
        label: item.year,
        onTap: () {},
      ),
    if (item.area.isNotEmpty)
      GlassChip(
        icon: const Icon(CupertinoIcons.globe),
        label: item.area,
        onTap: () {},
      ),
    if (item.category.isNotEmpty)
      GlassChip(
        icon: const Icon(CupertinoIcons.tag),
        label: item.category,
        onTap: () {},
      ),
    if (item.displayScore.isNotEmpty)
      GlassChip(
        icon: const Icon(CupertinoIcons.star_fill),
        label: '豆瓣 ${item.displayScore}',
        onTap: () {},
      ),
  ];
}

void openEpisode({
  required BuildContext context,
  required VodItem item,
  required PlaySource source,
  required PlayEpisode episode,
}) {
  Navigator.of(context).push(
    CupertinoPageRoute<void>(
      builder: (routeContext) => PlayerPage(
        title: item.name,
        sourceName: source.name,
        episode: episode,
      ),
    ),
  );
}

class DetailTextBlock extends StatelessWidget {
  const DetailTextBlock({required this.title, required this.text, super.key});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: CupertinoColors.label.resolveFrom(context),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: TextStyle(
            color: CupertinoColors.secondaryLabel.resolveFrom(context),
            fontSize: 15,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
