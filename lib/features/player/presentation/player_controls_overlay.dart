import 'dart:async';
import 'dart:ui' show FontFeature;

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:video_player/video_player.dart';

import '../../../cms/cms_models.dart';
import 'episode_list_panel.dart';

enum PlayerOverlayState { hidden, controls, episodes }

class PlayerControlsOverlay extends HookWidget {
  const PlayerControlsOverlay({
    required this.title,
    required this.source,
    required this.episodeIndex,
    required this.showEpisodeControls,
    required this.controller,
    required this.loading,
    required this.error,
    required this.onExit,
    required this.onEpisodeSelected,
    super.key,
  });

  final String title;
  final PlaySource source;
  final int episodeIndex;
  final bool showEpisodeControls;
  final VideoPlayerController controller;
  final bool loading;
  final Object? error;
  final VoidCallback onExit;
  final ValueChanged<int> onEpisodeSelected;

  @override
  Widget build(BuildContext context) {
    useListenable(controller);
    final overlayState = useState(PlayerOverlayState.controls);
    final controlsTimer = useRef<Timer?>(null);
    final draggedPosition = useState<double?>(null);
    final videoValue = controller.value;
    final durationMilliseconds = videoValue.isInitialized
        ? videoValue.duration.inMilliseconds.toDouble()
        : 0.0;
    final maximumPosition = durationMilliseconds <= 0
        ? 1.0
        : durationMilliseconds;
    final currentPosition = (draggedPosition.value ??
            videoValue.position.inMilliseconds.toDouble())
        .clamp(0.0, maximumPosition)
        .toDouble();

    void hideControls() {
      controlsTimer.value?.cancel();
      overlayState.value = PlayerOverlayState.hidden;
    }

    void showControls({bool keepVisible = false}) {
      controlsTimer.value?.cancel();
      overlayState.value = PlayerOverlayState.controls;
      if (!keepVisible) {
        controlsTimer.value = Timer(const Duration(seconds: 5), () {
          if (context.mounted) hideControls();
        });
      }
    }

    void handleBackgroundTap() {
      switch (overlayState.value) {
        case PlayerOverlayState.hidden:
          showControls();
          return;
        case PlayerOverlayState.controls:
          hideControls();
          return;
        case PlayerOverlayState.episodes:
          showControls();
          return;
      }
    }

    void selectEpisode({required int index}) {
      onEpisodeSelected(index);
      showControls();
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) showControls();
      });
      return () => controlsTimer.value?.cancel();
    }, const []);

    final controlsVisible = overlayState.value == PlayerOverlayState.controls;
    final previousEnabled = episodeIndex > 0;
    final nextEnabled = episodeIndex + 1 < source.episodes.length;

    const horizontalInset = 24.0;
    const topInset = 18.0;
    const episodePanelWidth = 280.0;
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: handleBackgroundTap,
        ),
        if (loading)
          const Center(
            child: GlassProgressIndicator.circular(
              useOwnLayer: true,
              size: 34,
              strokeWidth: 3,
            ),
          ),
        if (error != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Text(
                '播放失败\n$error',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
        Positioned(
          left: horizontalInset,
          top: topInset,
          child: PlayerOverlayAnimatedSwitcher(
            visible: controlsVisible,
            hiddenOffset: const Offset(0, -1),
            child: GlassIconButton(
              useOwnLayer: true,
              icon: const Icon(CupertinoIcons.chevron_back),
              onPressed: onExit,
            ),
          ),
        ),
        Positioned(
          left: horizontalInset + 58,
          right: horizontalInset,
          top: topInset,
          child: PlayerOverlayAnimatedSwitcher(
            visible: controlsVisible,
            hiddenOffset: const Offset(0, -1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GlassContainer(
                useOwnLayer: true,
                quality: GlassQuality.premium,
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 17),
                alignment: Alignment.centerLeft,
                shape: const LiquidRoundedSuperellipse(borderRadius: 46),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: horizontalInset,
          right: horizontalInset,
          bottom: 18,
          child: PlayerOverlayAnimatedSwitcher(
            visible: controlsVisible,
            hiddenOffset: const Offset(0, 1),
            child: GlassContainer(
              useOwnLayer: true,
              quality: GlassQuality.minimal,
              padding: const EdgeInsets.all(8),
              shape: const LiquidRoundedSuperellipse(borderRadius: 44),
              child: Row(
                children: [
                  if (showEpisodeControls) ...[
                    GlassIconButton(
                      useOwnLayer: true,
                      icon: const Icon(CupertinoIcons.backward_end),
                      onPressed: previousEnabled
                          ? () => selectEpisode(index: episodeIndex - 1)
                          : null,
                    ),
                    const SizedBox(width: 6),
                  ],
                  GlassIconButton(
                    useOwnLayer: true,
                    icon: Icon(
                      videoValue.isPlaying
                          ? CupertinoIcons.pause
                          : CupertinoIcons.play,
                    ),
                    onPressed: videoValue.isInitialized
                          ? () {
                              showControls();
                              unawaited(
                                videoValue.isPlaying
                                    ? controller.pause()
                                    : controller.play(),
                              );
                            }
                          : null,
                  ),
                  if (showEpisodeControls) ...[
                    const SizedBox(width: 6),
                    GlassIconButton(
                      useOwnLayer: true,
                      icon: const Icon(CupertinoIcons.forward_end),
                      onPressed: nextEnabled
                          ? () => selectEpisode(index: episodeIndex + 1)
                          : null,
                    ),
                  ],
                  const SizedBox(width: 14),
                  Text(
                    formatPlayerDuration(
                      duration: Duration(milliseconds: currentPosition.round()),
                    ),
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GlassSlider(
                      value: currentPosition,
                      min: 0,
                      max: maximumPosition,
                      thumbRadius: 10,
                      trackHeight: 4,
                      onChangeStart: videoValue.isInitialized
                          ? (value) {
                              draggedPosition.value = value;
                              showControls(keepVisible: true);
                            }
                          : null,
                      onChanged: videoValue.isInitialized
                          ? (value) => draggedPosition.value = value
                          : null,
                      onChangeEnd: videoValue.isInitialized
                          ? (value) {
                              draggedPosition.value = null;
                              unawaited(
                                controller.seekTo(
                                  Duration(milliseconds: value.round()),
                                ),
                              );
                              showControls();
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    formatPlayerDuration(duration: videoValue.duration),
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  if (showEpisodeControls) ...[
                    const SizedBox(width: 14),
                    GlassIconButton(
                      useOwnLayer: true,
                      icon: const Icon(CupertinoIcons.list_bullet),
                      onPressed: () {
                        controlsTimer.value?.cancel();
                        overlayState.value = PlayerOverlayState.episodes;
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          bottom: 16,
          child: PlayerOverlayAnimatedSwitcher(
            visible:
                showEpisodeControls &&
                overlayState.value == PlayerOverlayState.episodes,
            hiddenOffset: const Offset(1, 0),
            child: EpisodeListPanel(
              source: source,
              episodeIndex: episodeIndex,
              width: episodePanelWidth,
              onSelected: (index) {
                controlsTimer.value?.cancel();
                onEpisodeSelected(index);
                overlayState.value = PlayerOverlayState.episodes;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class PlayerOverlayAnimatedSwitcher extends StatelessWidget {
  const PlayerOverlayAnimatedSwitcher({
    required this.visible,
    required this.hiddenOffset,
    required this.child,
    super.key,
  });

  final bool visible;
  final Offset hiddenOffset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: hiddenOffset,
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: visible
            ? KeyedSubtree(key: const ValueKey('visible'), child: child)
            : const SizedBox.shrink(key: ValueKey('hidden')),
      ),
    );
  }
}

String formatPlayerDuration({required Duration duration}) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
}
