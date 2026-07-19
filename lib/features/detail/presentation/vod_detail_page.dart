import 'dart:async';

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
import '../../library/application/library_providers.dart';
import '../../player/presentation/continue_playing_button.dart';
import '../../player/presentation/player_page.dart';
import '../application/vod_detail_providers.dart';

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
    final detailArguments = (id: vodId, initialItem: initialItem);
    final resumeData = ref.watch(vodResumeDataProvider(detailArguments));
    final scrollController = useScrollController();
    final scrollOffset = useValueNotifier(0.0);

    useEffect(() {
      void onScroll() {
        scrollOffset.value = scrollController.offset;
      }

      scrollController.addListener(onScroll);
      return () {
        scrollController.removeListener(onScroll);
      };
    }, [scrollController, scrollOffset]);

    final continuePlayingBar = resumeData == null
        ? null
        : ContinuePlayingButton(
            title: '继续播放',
            subtitle:
                '${resumeData.progress.sourceName} · '
                '${resumeData.progress.episodeName} · '
                '${formatPlaybackPosition(milliseconds: resumeData.progress.positionMilliseconds)}',
            onTap: () => openEpisode(
              context: context,
              item: resumeData.item,
              source: resumeData.source,
              episode: resumeData.episode,
              initialPosition: Duration(
                milliseconds: resumeData.progress.positionMilliseconds,
              ),
            ),
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
          VodFavoriteAction(vodId: vodId, detailArguments: detailArguments),
        ],
      ),
      bottomBar: continuePlayingBar,
      bottomBarHeight: continuePlayingBar == null ? null : 84,
      body: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          VodDetailCoverSliver(
            detailArguments: detailArguments,
            scrollOffset: scrollOffset,
          ),
          VodDetailContentSliver(
            detailArguments: detailArguments,
            hasResumeData: resumeData != null,
          ),
        ],
      ),
    );
  }
}

class VodFavoriteAction extends ConsumerWidget {
  const VodFavoriteAction({
    required this.vodId,
    required this.detailArguments,
    super.key,
  });

  final int vodId;
  final VodDetailArguments detailArguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(vodDetailProvider(detailArguments));
    final isFavorite = ref.watch(vodFavoriteProvider(vodId));

    return detail.when(
      data: (item) => isFavorite.when(
        data: (favorite) => GlassIconButton(
          icon: Icon(
            favorite
                ? CupertinoIcons.rectangle_stack_fill
                : CupertinoIcons.rectangle_stack_badge_plus,
          ),
          useOwnLayer: true,
          onPressed: () => unawaited(
            ref.read(libraryCommandsProvider).toggleFavorite(item: item),
          ),
        ),
        loading: buildToolbarLoading,
        error: (error, stackTrace) => GlassIconButton(
          icon: const Icon(CupertinoIcons.refresh),
          useOwnLayer: true,
          onPressed: () => ref.invalidate(vodFavoriteProvider(vodId)),
        ),
      ),
      loading: buildToolbarLoading,
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}

class VodDetailCoverSliver extends ConsumerWidget {
  const VodDetailCoverSliver({
    required this.detailArguments,
    required this.scrollOffset,
    super.key,
  });

  final VodDetailArguments detailArguments;
  final ValueNotifier<double> scrollOffset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(vodDetailProvider(detailArguments));
    return SliverToBoxAdapter(
      child: ClipRect(
        child: SizedBox(
          height: 500,
          child: ValueListenableBuilder<double>(
            valueListenable: scrollOffset,
            builder: (context, offset, child) => Transform.translate(
              offset: Offset(0, offset * .5),
              child: child,
            ),
            child: detail.when(
              data: (item) => Hero(
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
              loading: () => const Center(child: CupertinoActivityIndicator()),
              error: (error, stackTrace) =>
                  buildCachedImageError(context, '', error),
            ),
          ),
        ),
      ),
    );
  }
}

class VodDetailContentSliver extends ConsumerWidget {
  const VodDetailContentSliver({
    required this.detailArguments,
    required this.hasResumeData,
    super.key,
  });

  final VodDetailArguments detailArguments;
  final bool hasResumeData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(vodDetailProvider(detailArguments));
    return detail.when(
      data: (item) => SliverLayoutBuilder(
        builder: (context, constraints) => SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.viewportMainAxisExtent,
            ),
            child: VodDetailContent(item: item, hasResumeData: hasResumeData),
          ),
        ),
      ),
      loading: () => const ContentStateSliver.loading(),
      error: (error, stackTrace) => ContentStateSliver.error(
        error: error,
        onRetry: () => ref.invalidate(vodDetailProvider(detailArguments)),
      ),
    );
  }
}

class VodDetailContent extends StatelessWidget {
  const VodDetailContent({
    required this.item,
    required this.hasResumeData,
    super.key,
  });

  final VodItem item;
  final bool hasResumeData;

  @override
  Widget build(BuildContext context) {
    final sources = parsePlaySources(
      playFrom: item.playFrom,
      playUrl: item.playUrl,
    );
    final actors = splitCmsValues(value: item.actor);
    final directors = splitCmsValues(value: item.director);
    final categories = splitCmsValues(value: item.category);
    final summary = htmlToPlainText(html: item.summary);

    return Padding(
      padding: EdgeInsets.fromLTRB(22, 24, 22, hasResumeData ? 120 : 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
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
          Text(
            summary,
            style: TextStyle(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
              fontSize: 15,
              height: 1.55,
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: buildMetadataChips(item: item),
          ),
          buildValueChips(values: categories, icon: CupertinoIcons.tag),
          buildValueChips(values: actors, icon: CupertinoIcons.person_2),
          buildValueChips(values: directors, icon: CupertinoIcons.video_camera),
          if (sources.isEmpty)
            Text(
              '暂无可播放线路',
              style: TextStyle(
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            )
          else
            for (final source in sources) ...[
              Text(
                "数据源:${source.name}",
                style: TextStyle(
                  color: CupertinoColors.label.resolveFrom(context),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final episode in source.episodes)
                    GlassChip(
                      useOwnLayer: true,
                      quality: .minimal,
                      icon: const Icon(CupertinoIcons.play_rectangle),
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
    );
  }
}

Widget buildToolbarLoading() {
  return const SizedBox(
    width: 44,
    height: 44,
    child: Center(child: CupertinoActivityIndicator(radius: 10)),
  );
}

Widget buildValueChips({required List<String> values, required IconData icon}) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final value in values)
        GlassChip(
          useOwnLayer: true,
          quality: .minimal,
          icon: Icon(icon),
          label: value,
          onTap: () {},
        ),
    ],
  );
}

List<Widget> buildMetadataChips({required VodItem item}) {
  return [
    // if (item.remarks.isNotEmpty)
    //   GlassChip(
    //     useOwnLayer: true,
    //     quality: .minimal,
    //     icon: const Icon(CupertinoIcons.info_circle),
    //     label: item.remarks,
    //     onTap: () {},
    //   ),
    if (item.year.isNotEmpty)
      GlassChip(
        useOwnLayer: true,
        quality: .minimal,
        icon: const Icon(CupertinoIcons.calendar),
        label: item.year,
        onTap: () {},
      ),
    if (item.area.isNotEmpty)
      GlassChip(
        useOwnLayer: true,
        quality: .minimal,
        icon: const Icon(CupertinoIcons.globe),
        label: item.area,
        onTap: () {},
      ),
    if (item.language.isNotEmpty)
      GlassChip(
        useOwnLayer: true,
        quality: .minimal,
        icon: const Icon(CupertinoIcons.captions_bubble),
        label: item.language,
        onTap: () {},
      ),
    if (item.duration.isNotEmpty)
      GlassChip(
        useOwnLayer: true,
        quality: .minimal,
        icon: const Icon(CupertinoIcons.clock),
        label: item.duration,
        onTap: () {},
      ),
    if (item.displayScore.isNotEmpty)
      GlassChip(
        useOwnLayer: true,
        quality: .minimal,
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

String htmlToPlainText({required String html}) {
  return html
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<li[^>]*>', caseSensitive: false), '• ')
      .replaceAll(RegExp(r'</li\s*>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'<[^>]+>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&amp;', '&')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
}
