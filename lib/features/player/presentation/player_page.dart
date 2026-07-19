import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:video_player/video_player.dart';

import '../../../cms/cms_models.dart';

class PlayerPage extends HookConsumerWidget {
  const PlayerPage({
    required this.title,
    required this.sourceName,
    required this.episode,
    super.key,
  });

  final String title;
  final String sourceName;
  final PlayEpisode episode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(
      () => VideoPlayerController.networkUrl(Uri.parse(episode.url)),
      [episode.url],
    );
    final initialization = useMemoized(controller.initialize, [controller]);
    final initialized = useFuture(initialization);
    useListenable(controller);
    useEffect(() {
      return () {
        controller.dispose();
      };
    }, [controller]);

    return GlassScaffold(
      edgeToEdge: true,
      statusBarStyle: GlassStatusBarStyle.light,
      background: const ColoredBox(color: CupertinoColors.black),
      appBar: GlassAppBar(
        leading: GlassIconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          useOwnLayer: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: initialized.connectionState != ConnectionState.done
                    ? const GlassProgressIndicator.circular(size: 38)
                    : initialized.hasError
                    ? Padding(
                        padding: const EdgeInsets.all(28),
                        child: Text(
                          '播放失败\n${initialized.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: CupertinoColors.white),
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: controller.value.aspectRatio == 0
                            ? 16 / 9
                            : controller.value.aspectRatio,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            VideoPlayer(controller),
                            Center(
                              child: GlassIconButton(
                                icon: Icon(
                                  controller.value.isPlaying
                                      ? CupertinoIcons.pause_fill
                                      : CupertinoIcons.play_fill,
                                  size: 34,
                                ),
                                useOwnLayer: true,
                                onPressed: () {
                                  controller.value.isPlaying
                                      ? controller.pause()
                                      : controller.play();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$sourceName · ${episode.name}',
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 15,
                    ),
                  ),
                  if (controller.value.isInitialized) ...[
                    const SizedBox(height: 14),
                    VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Color(0xFFFF375F),
                        bufferedColor: CupertinoColors.systemGrey,
                        backgroundColor: CupertinoColors.darkBackgroundGray,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
