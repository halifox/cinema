import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../cms/cms_models.dart';
import '../../library/application/library_providers.dart';
import 'player_controls_overlay.dart';
import 'player_playback_hook.dart';

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
    final playback = usePlayerPlayback(
      item: item,
      source: source,
      initialEpisode: episode,
      initialPosition: initialPosition,
      libraryCommands: ref.watch(libraryCommandsProvider),
    );
    final exitRequested = useRef(false);

    Future<void> exitPlayback() async {
      if (exitRequested.value) return;
      exitRequested.value = true;
      await playback.pause();
      if (context.mounted) Navigator.of(context).pop();
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) playback.pause();
      },
      child: CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
        child: GlassScaffold(
          edgeToEdge: true,
          contentAwareBrightness: false,
          statusBarStyle: GlassStatusBarStyle.auto,
          background: const ColoredBox(color: CupertinoColors.black),
          body: Stack(
            fit: StackFit.expand,
            children: [
              if (!playback.initialization.hasError)
                Video(
                  controller: playback.videoController,
                  controls: NoVideoControls,
                  fit: BoxFit.contain,
                ),
              PlayerControlsOverlay(
                title: item.name,
                source: source,
                episodeIndex: playback.episodeIndex,
                player: playback.player,
                loading:
                    playback.initialization.connectionState !=
                    ConnectionState.done,
                error: playback.initialization.error,
                onExit: exitPlayback,
                onEpisodeSelected: (index) =>
                    playback.selectEpisode(index: index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
