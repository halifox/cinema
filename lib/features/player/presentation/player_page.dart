import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

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
    final controller = useMemoized(
      () => VideoPlayerController.networkUrl(Uri.parse(activeEpisode.url)),
      [activeEpisode.url],
    );
    final playbackPosition = activeEpisode.url == episode.url
        ? initialPosition
        : Duration.zero;
    final initialization = useMemoized(() async {
      await controller.initialize();
      if (playbackPosition > Duration.zero &&
          playbackPosition < controller.value.duration) {
        await controller.seekTo(playbackPosition);
      }
      await controller.play();
    }, [controller, playbackPosition]);
    final initialized = useFuture(initialization);
    final saveTimer = useRef<Timer?>(null);

    useEffect(() {
      unawaited(configurePlaybackChrome());
      return () {
        unawaited(restoreAppChrome());
      };
    }, const []);

    useEffect(() {
      Future<void> saveProgress() {
        final position = controller.value.isInitialized
            ? controller.value.position
            : playbackPosition;
        return ref.read(libraryDatabaseProvider).recordViewing(
          item: item,
          source: source,
          episode: activeEpisode,
          positionMilliseconds: position.inMilliseconds,
        );
      }

      void scheduleProgressSave() {
        if (!controller.value.isInitialized || saveTimer.value != null) return;
        saveTimer.value = Timer(const Duration(seconds: 2), () {
          saveTimer.value = null;
          unawaited(saveProgress());
        });
      }

      controller.addListener(scheduleProgressSave);
      unawaited(saveProgress());
      return () {
        controller.removeListener(scheduleProgressSave);
        saveTimer.value?.cancel();
        saveTimer.value = null;
        unawaited(saveProgress());
        unawaited(controller.dispose());
      };
    }, [
      controller,
      item.id,
      source.name,
      activeEpisode.name,
      activeEpisode.url,
      playbackPosition,
    ]);

    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (initialized.connectionState == ConnectionState.done &&
                !initialized.hasError)
              SafeArea(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio == 0
                        ? 16 / 9
                        : controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
            SafeArea(
              child: PlayerControlsOverlay(
                title: item.name,
                source: source,
                episodeIndex: episodeIndex.value,
                showEpisodeControls:
                    item.parentTypeId != 1 && source.episodes.length > 1,
                controller: controller,
                loading: initialized.connectionState != ConnectionState.done,
                error: initialized.error,
                onExit: () => Navigator.of(context).pop(),
                onEpisodeSelected: (index) {
                  if (index == episodeIndex.value) return;
                  episodeIndex.value = index;
                },
              ),
            ),
          ],
        ),
      ),
    );
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
