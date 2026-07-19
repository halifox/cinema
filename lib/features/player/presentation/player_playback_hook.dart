import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../cms/cms_models.dart';
import '../../library/application/library_providers.dart';

class PlayerPlaybackController {
  const PlayerPlaybackController({
    required this.player,
    required this.videoController,
    required this.initialization,
    required this.episodeIndexListenable,
    required this.pausePlayback,
  });

  final Player player;
  final VideoController videoController;
  final AsyncSnapshot<void> initialization;
  final ValueNotifier<int> episodeIndexListenable;
  final Future<void> Function() pausePlayback;

  int get episodeIndex => episodeIndexListenable.value;

  void selectEpisode({required int index}) {
    if (index == episodeIndex) return;
    episodeIndexListenable.value = index;
  }

  Future<void> pause() => pausePlayback();
}

PlayerPlaybackController usePlayerPlayback({
  required VodItem item,
  required PlaySource source,
  required PlayEpisode initialEpisode,
  required Duration initialPosition,
  required LibraryCommands libraryCommands,
}) {
  final initialEpisodeIndex = source.episodes.indexWhere(
    (candidate) => candidate.url == initialEpisode.url,
  );
  final episodeIndex = useState(
    initialEpisodeIndex < 0 ? 0 : initialEpisodeIndex,
  );
  final activeEpisode = source.episodes[episodeIndex.value];
  final session = useMemoized(
    () => PlayerPlaybackSession(player: Player()),
    [activeEpisode.url],
  );
  final player = session.player;
  final videoController = useMemoized(
    () => VideoController(player),
    [player],
  );
  final playbackPosition = activeEpisode.url == initialEpisode.url
      ? initialPosition
      : Duration.zero;
  final initialization = useMemoized(() async {
    await player.open(
      Media(
        activeEpisode.url,
        start: playbackPosition > Duration.zero ? playbackPosition : null,
      ),
      play: false,
    );
    if (!session.allowsPlayback) return;
    await player.play();
  }, [session, player, activeEpisode.url, playbackPosition]);
  final initializationSnapshot = useFuture(initialization);
  final saveTimer = useRef<Timer?>(null);

  useEffect(() {
    unawaited(configurePlaybackChrome());
    return () => unawaited(restoreAppChrome());
  }, const []);

  useEffect(
    () {
      var isInitialized = false;

      Future<void> trackInitialization() async {
        try {
          await initialization;
          isInitialized = true;
        } on Object {
          // The page presents initialization errors from useFuture.
        }
      }

      Future<void> saveProgress() {
        final position = isInitialized
            ? player.state.position
            : playbackPosition;
        return libraryCommands.recordViewing(
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
        unawaited(session.dispose());
      };
    },
    [
      session,
      player,
      initialization,
      libraryCommands,
      item.id,
      source.name,
      activeEpisode.name,
      activeEpisode.url,
      playbackPosition,
    ],
  );

  return PlayerPlaybackController(
    player: player,
    videoController: videoController,
    initialization: initializationSnapshot,
    episodeIndexListenable: episodeIndex,
    pausePlayback: session.pause,
  );
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
      // The platform backend may already have released the player.
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
