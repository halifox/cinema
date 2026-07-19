import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/cached_image_feedback.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../favorites/application/favorites_provider.dart';
import '../../library/data/library_database.dart';
import '../../player/presentation/continue_playing_button.dart';
import '../../player/presentation/player_page.dart';

final vodViewingProgressProvider =
    StreamProvider.family<VodViewingProgress?, int>((ref, vodId) {
      return ref
          .watch(libraryDatabaseProvider)
          .watchViewingProgress(vodId: vodId);
    });

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
    final isFavorite = ref.watch(vodFavoriteProvider(vodId)).value ?? false;
    final viewingProgress = ref.watch(vodViewingProgressProvider(vodId)).value;
    final sources = parsePlaySources(
      playFrom: item.playFrom,
      playUrl: item.playUrl,
    );
    final resumeTarget = viewingProgress == null
        ? null
        : resolveResumeTarget(
            sources: sources,
            progress: viewingProgress,
          );
    final scrollController = useScrollController();
    final scrollOffset = useState(0.0);

    useEffect(() {
      void onScroll() {
        scrollOffset.value = scrollController.offset;
      }

      scrollController.addListener(onScroll);
      return () {
        scrollController.removeListener(onScroll);
      };
    }, [scrollController]);

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
              isFavorite
                  ? CupertinoIcons.rectangle_stack_fill
                  : CupertinoIcons.rectangle_stack_badge_plus,
            ),
            useOwnLayer: true,
            onPressed: () => ref
                .read(libraryDatabaseProvider)
                .toggleFavorite(item: item),
          ),
        ],
      ),
      bottomBar: viewingProgress == null
          ? null
          : ContinuePlayingButton(
              title: '继续播放',
              subtitle:
                  '${viewingProgress.sourceName} · '
                  '${viewingProgress.episodeName} · '
                  '${formatPlaybackPosition(
                    milliseconds: viewingProgress.positionMilliseconds,
                  )}',
              onTap: () {
                final target = resumeTarget!;
                openEpisode(
                  context: context,
                  item: item,
                  source: target.source,
                  episode: target.episode,
                  initialPosition: Duration(
                    milliseconds: viewingProgress.positionMilliseconds,
                  ),
                );
              },
            ),
      bottomBarHeight: viewingProgress == null ? null : 84,
      body: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: ClipRect(
              child: SizedBox(
                height: 500,
                child: Transform.translate(
                  offset: Offset(0, scrollOffset.value * .5),
                  child: Hero(
                    tag: 'vod-cover-${item.id}',
                    child: item.picture.isEmpty
                        ? buildCachedImageError(
                            context,
                            '',
                            StateError('empty'),
                          )
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
              ),
            ),
          detail.when(
            data: (detailItem) {
              final detailSources = parsePlaySources(
                playFrom: detailItem.playFrom,
                playUrl: detailItem.playUrl,
              );
              final actors = splitCmsValues(value: detailItem.actor);
              final directors = splitCmsValues(value: detailItem.director);
              final categories = splitCmsValues(value: detailItem.category);
              return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  22,
                  24,
                  22,
                  viewingProgress == null ? 44 : 120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      detailItem.name,
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.16,
                        letterSpacing: -.7,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: buildMetadataChips(item: detailItem),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final actor in actors)
                          GlassChip(
                            icon: const Icon(CupertinoIcons.person_2),
                            label: actor,
                            onTap: () {},
                          ),
                      ],
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final director in directors)
                          GlassChip(
                            icon: const Icon(CupertinoIcons.video_camera),
                            label: director,
                            onTap: () {},
                          ),
                      ],
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final category in categories)
                          GlassChip(
                            icon: const Icon(CupertinoIcons.tag),
                            label: category,
                            onTap: () {},
                          ),
                      ],
                    ),
                    if (detailItem.summary.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      GlassCard(
                        child: DetailTextBlock(
                          title: '简介',
                          text: detailItem.summary,
                        ),
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
                    if (detailSources.isEmpty)
                      Text(
                        '暂无可播放线路',
                        style: TextStyle(
                          color: CupertinoColors.secondaryLabel.resolveFrom(
                            context,
                          ),
                        ),
                      )
                    else
                      for (final source in detailSources) ...[
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
                                  item: detailItem,
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
              );
            },
            loading: () => const ContentStateSliver.loading(),
            error: (error, stackTrace) => ContentStateSliver.error(
              error: error,
              onRetry: () => ref.invalidate(vodDetailProvider(vodId)),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> buildMetadataChips({required VodItem item}) {
  return [
    if (item.remarks.isNotEmpty)
      GlassChip(
        icon: const Icon(CupertinoIcons.info_circle),
        label: item.remarks,
        onTap: () {},
      ),
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
    if (item.language.isNotEmpty)
      GlassChip(
        icon: const Icon(CupertinoIcons.captions_bubble),
        label: item.language,
        onTap: () {},
      ),
    if (item.duration.isNotEmpty)
      GlassChip(
        icon: const Icon(CupertinoIcons.clock),
        label: item.duration,
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

List<String> splitCmsValues({required String value}) {
  return value
      .split(RegExp('[,，]'))
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toList(growable: false);
}

void openEpisode({
  required BuildContext context,
  required VodItem item,
  required PlaySource source,
  required PlayEpisode episode,
  Duration initialPosition = Duration.zero,
}) {
  Navigator.of(context).push(
    CupertinoPageRoute<void>(
      builder: (routeContext) => PlayerPage(
        item: item,
        source: source,
        episode: episode,
        initialPosition: initialPosition,
      ),
    ),
  );
}

String formatPlaybackPosition({required int milliseconds}) {
  final duration = Duration(milliseconds: milliseconds);
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
}

({PlaySource source, PlayEpisode episode}) resolveResumeTarget({
  required List<PlaySource> sources,
  required VodViewingProgress progress,
}) {
  final sourceIndex = sources.indexWhere(
    (source) =>
        source.name == progress.sourceName &&
        source.episodes.any(
          (episode) => episode.url == progress.episodeUrl,
        ),
  );
  if (sourceIndex < 0) {
    final storedEpisode = PlayEpisode(
      name: progress.episodeName,
      url: progress.episodeUrl,
    );
    return (
      source: PlaySource(
        name: progress.sourceName,
        episodes: [storedEpisode],
      ),
      episode: storedEpisode,
    );
  }

  final source = sources[sourceIndex];
  final episode = source.episodes.firstWhere(
    (candidate) => candidate.url == progress.episodeUrl,
  );
  return (source: source, episode: episode);
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
