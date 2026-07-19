import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../cms/cms_models.dart';
import '../../library/data/library_database.dart';
import 'player_controls_overlay.dart';

class PlayerPage extends HookConsumerWidget {
  const PlayerPage({
    required this.item,
    required this.source,
    required this.episode,
    this.initialPosition = Duration.zero,
    super.key,
  });

  final VodItem item;
  final PlaySource source;
  final PlayEpisode episode;
  final Duration initialPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialEpisodeIndex = source.episodes.indexWhere(
      (candidate) => candidate.url == episode.url,
    );
    final episodeIndex = useState(
      initialEpisodeIndex < 0 ? 0 : initialEpisodeIndex,
    );
    final activeEpisode = source.episodes[episodeIndex.value];
    final playbackSession = useMemoized(
      () => PlayerPlaybackSession(player: Player()),
      [activeEpisode.url],
    );
    final player = playbackSession.player;
    final controller = useMemoized(
      () => VideoController(player),
      [player],
    );
    final playbackPosition = activeEpisode.url == episode.url
        ? initialPosition
        : Duration.zero;
    final initialization = useMemoized(() async {
      await player.open(Media(activeEpisode.url), play: false);
      if (!playbackSession.allowsPlayback) return;
      if (playbackPosition > Duration.zero &&
          playbackPosition < player.state.duration) {
        await player.seek(playbackPosition);
      }
      if (!playbackSession.allowsPlayback) return;
      await player.play();
    }, [playbackSession, player, activeEpisode.url, playbackPosition]);
    final initialized = useFuture(initialization);
    final saveTimer = useRef<Timer?>(null);
    final exitRequested = useRef(false);

    useEffect(() {
      unawaited(configurePlaybackChrome());
      return () {
        unawaited(restoreAppChrome());
      };
    }, const []);

    useEffect(
      () {
        var isInitialized = false;

        Future<void> trackInitialization() async {
          try {
            await initialization;
            isInitialized = true;
          } on Object {
            // The initialization error is displayed by the controls overlay.
          }
        }

        Future<void> saveProgress() {
          final position = isInitialized
              ? player.state.position
              : playbackPosition;
          return ref
              .read(libraryDatabaseProvider)
              .recordViewing(
                item: item,
                source: source,
                episode: activeEpisode,
                positionMilliseconds: position.inMilliseconds,
              );
        }

        void scheduleProgressSave() {
          if (saveTimer.value != null) return;
          saveTimer.value = Timer(const Duration(seconds: 2), () {
            saveTimer.value = null;
            unawaited(saveProgress());
          });
        }

        final positionSubscription = player.stream.position.listen(
          (position) => scheduleProgressSave(),
        );
        unawaited(trackInitialization());
        unawaited(saveProgress());
        return () {
          unawaited(positionSubscription.cancel());
          saveTimer.value?.cancel();
          saveTimer.value = null;
          unawaited(saveProgress());
          unawaited(playbackSession.dispose());
        };
      },
      [
        playbackSession,
        player,
        initialization,
        item.id,
        source.name,
        activeEpisode.name,
        activeEpisode.url,
        playbackPosition,
      ],
    );

    Future<void> exitPlayback() async {
      if (exitRequested.value) return;
      exitRequested.value = true;
      await playbackSession.pause();
      if (context.mounted) Navigator.of(context).pop();
    }

    return PopScope<void>(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) unawaited(playbackSession.pause());
      },
      child: CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
        child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (!initialized.hasError)
                Video(
                  controller: controller,
                  controls: NoVideoControls,
                  fit: BoxFit.contain,
                ),
              PlayerControlsOverlay(
                title: item.name,
                source: source,
                episodeIndex: episodeIndex.value,
                showEpisodeControls:
                    item.parentTypeId != 1 && source.episodes.length > 1,
                player: player,
                loading: initialized.connectionState != ConnectionState.done,
                error: initialized.error,
                onExit: () => unawaited(exitPlayback()),
                onEpisodeSelected: (index) {
                  if (index == episodeIndex.value) return;
                  episodeIndex.value = index;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerPlaybackSession {
  PlayerPlaybackSession({required this.player});

  final Player player;
  bool allowsPlayback = true;
  Future<void>? pauseOperation;
  Future<void>? disposeOperation;

  Future<void> pause() {
    allowsPlayback = false;
    return pauseOperation ??= pausePlayer();
  }

  Future<void> pausePlayer() async {
    try {
      await player.pause();
    } on Object {
      // Disposal below remains the final fallback for native player resources.
    }
  }

  Future<void> dispose() {
    allowsPlayback = false;
    return disposeOperation ??= disposePlayer();
  }

  Future<void> disposePlayer() async {
    await pause();
    try {
      await player.dispose();
    } on Object {
      // The player may already have been released by the platform backend.
    }
  }
}

Future<void> configurePlaybackChrome() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

Future<void> restoreAppChrome() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
