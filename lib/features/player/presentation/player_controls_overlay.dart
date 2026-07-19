import 'dart:async';
import 'dart:ui' show FontFeature;

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:media_kit/media_kit.dart';

import '../../../cms/cms_models.dart';
import '../../../shared/presentation/theme/app_theme.dart';
import 'episode_list_panel.dart';

enum PlayerOverlayState { hidden, controls, episodes }

const playerPlaybackRates = <double>[0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

class PlayerControlsOverlay extends HookWidget {
  const PlayerControlsOverlay({
    required this.title,
    required this.source,
    required this.episodeIndex,
    required this.showEpisodeControls,
    required this.player,
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
  final Player player;
  final bool loading;
  final Object? error;
  final VoidCallback onExit;
  final ValueChanged<int> onEpisodeSelected;

  @override
  Widget build(BuildContext context) {
    final overlayState = useState(PlayerOverlayState.controls);
    final controlsTimer = useRef<Timer?>(null);
    final draggedPosition = useState<double?>(null);
    final selectedPlaybackRate = useState(1.0);
    final position = useStream(
      player.stream.position,
      initialData: player.state.position,
      preserveState: false,
    ).data!;
    final duration = useStream(
      player.stream.duration,
      initialData: player.state.duration,
      preserveState: false,
    ).data!;
    final playing = useStream(
      player.stream.playing,
      initialData: player.state.playing,
      preserveState: false,
    ).data!;
    final buffering = useStream(
      player.stream.buffering,
      initialData: player.state.buffering,
      preserveState: false,
    ).data!;
    final playbackError = useStream(
      player.stream.error,
      preserveState: false,
    ).data;
    final effectiveError = error ?? playbackError;
    final episodeName = source.episodes[episodeIndex].name;
    final durationMilliseconds = duration.inMilliseconds.toDouble();
    final maximumPosition = durationMilliseconds <= 0
        ? 1.0
        : durationMilliseconds;
    final currentPosition = (draggedPosition.value ??
            position.inMilliseconds.toDouble())
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

    void showPlaybackToast({
      required String message,
      GlassToastType type = GlassToastType.warning,
    }) {
      showControls();
      GlassToast.show(
        context,
        message: message,
        type: type,
        position: GlassToastPosition.center,
      );
    }

    void selectPreviousEpisode() {
      if (episodeIndex <= 0) {
        showPlaybackToast(message: '已经是第一集了');
        return;
      }
      selectEpisode(index: episodeIndex - 1);
    }

    void selectNextEpisode() {
      if (episodeIndex + 1 >= source.episodes.length) {
        showPlaybackToast(message: '已经是最后一集了');
        return;
      }
      selectEpisode(index: episodeIndex + 1);
    }

    void togglePlayback() {
      if (loading) {
        showPlaybackToast(
          message: '视频正在加载，请稍候',
          type: GlassToastType.info,
        );
        return;
      }
      if (effectiveError != null) {
        showPlaybackToast(
          message: '播放暂不可用，请稍后重试',
          type: GlassToastType.error,
        );
        return;
      }
      showControls();
      unawaited(playing ? player.pause() : player.play());
    }

    Future<void> selectPlaybackRate({required double rate}) async {
      final previousRate = selectedPlaybackRate.value;
      selectedPlaybackRate.value = rate;
      showControls();
      try {
        await player.setRate(rate);
      } on Object {
        if (!context.mounted) return;
        selectedPlaybackRate.value = previousRate;
        showPlaybackToast(
          message: '倍速切换失败，请稍后重试',
          type: GlassToastType.error,
        );
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) showControls();
      });
      return () => controlsTimer.value?.cancel();
    }, const []);

    useEffect(() {
      if (effectiveError == null) return null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        showPlaybackToast(
          message: '播放失败：$effectiveError',
          type: GlassToastType.error,
        );
      });
      return null;
    }, [effectiveError]);

    useEffect(() {
      if (selectedPlaybackRate.value == 1.0) return null;
      var effectActive = true;

      Future<void> restorePlaybackRate() async {
        try {
          await player.setRate(selectedPlaybackRate.value);
        } on Object {
          if (!effectActive || !context.mounted) return;
          selectedPlaybackRate.value = 1.0;
          showPlaybackToast(
            message: '倍速恢复失败，已切换为正常速度',
            type: GlassToastType.error,
          );
        }
      }

      unawaited(restorePlaybackRate());
      return () => effectActive = false;
    }, [player]);

    final controlsVisible = overlayState.value == PlayerOverlayState.controls;
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
        if (loading || buffering)
          const Center(
            child: GlassProgressIndicator.circular(
              useOwnLayer: true,
              size: 34,
              strokeWidth: 3 ),
          ),
        Positioned(
          left: horizontalInset,
          top: topInset,
          child: PlayerOverlayAnimatedSwitcher(
            visible: controlsVisible,
            hiddenOffset: const Offset(0, -1),
            child: GlassIconButton(
              useOwnLayer: true,
              quality: .premium,
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
                quality: .premium,
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 17),
                alignment: Alignment.centerLeft,
                shape: const LiquidRoundedSuperellipse(borderRadius: 46),
                child: Text(
                  '${title} · ${episodeName}',
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
                      quality: .premium,
                      icon: const Icon(CupertinoIcons.backward_end),
                      onPressed: selectPreviousEpisode,
                    ),
                    const SizedBox(width: 6),
                  ],
                  GlassIconButton(
                    useOwnLayer: true,
                    quality: .premium,
                    icon: Icon(
                      playing
                          ? CupertinoIcons.pause
                          : CupertinoIcons.play,
                    ),
                    onPressed: togglePlayback,
                  ),
                  if (showEpisodeControls) ...[
                    const SizedBox(width: 6),
                    GlassIconButton(
                      useOwnLayer: true,
                      quality: .premium,
                      icon: const Icon(CupertinoIcons.forward_end),
                      onPressed: selectNextEpisode,
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
                      quality: .premium,
                      value: currentPosition,
                      min: 0,
                      max: maximumPosition,
                      thumbRadius: 10,
                      trackHeight: 4,
                      onChangeStart: duration > Duration.zero
                          ? (value) {
                              draggedPosition.value = value;
                              showControls(keepVisible: true);
                            }
                          : null,
                      onChanged: duration > Duration.zero
                          ? (value) => draggedPosition.value = value
                          : null,
                      onChangeEnd: duration > Duration.zero
                          ? (value) {
                              draggedPosition.value = null;
                              unawaited(
                                player.seek(
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
                    formatPlayerDuration(duration: duration),
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Listener(
                    onPointerDown: (event) => showControls(keepVisible: true),
                    child: PlayerPlaybackRateAction(
                      selectedRate: selectedPlaybackRate.value,
                      onSelected: (rate) => unawaited(
                        selectPlaybackRate(rate: rate),
                      ),
                    ),
                  ),
                  if (showEpisodeControls) ...[
                    const SizedBox(width: 14),
                    GlassIconButton(
                      useOwnLayer: true,
                      quality: .premium,
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

class PlayerPlaybackRateAction extends StatelessWidget {
  const PlayerPlaybackRateAction({
    required this.selectedRate,
    required this.onSelected,
    super.key,
  });

  final double selectedRate;
  final ValueChanged<double> onSelected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '选择播放倍速，当前 ${formatPlaybackRate(rate: selectedRate)} 倍',
      child: GlassPullDownButton(
        icon: const Icon(CupertinoIcons.speedometer),
        quality: GlassQuality.premium,
        items: [
          for (final rate in playerPlaybackRates)
            GlassMenuItem(
              title: '${formatPlaybackRate(rate: rate)} 倍',
              trailing: rate == selectedRate
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
              onTap: () => onSelected(rate),
            ),
        ],
      ),
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

String formatPlaybackRate({required double rate}) {
  return rate == rate.roundToDouble()
      ? rate.toStringAsFixed(1)
      : rate.toStringAsFixed(2).replaceFirst(RegExp(r'0$'), '');
}
