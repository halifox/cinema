import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';

class EpisodeListPanel extends HookWidget {
  const EpisodeListPanel({
    required this.source,
    required this.episodeIndex,
    required this.onSelected,
    required this.onClose,
    super.key,
  });

  final PlaySource source;
  final int episodeIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    const tileHeight = 48.0;
    final initialScrollOffset = (episodeIndex * tileHeight - tileHeight * 2)
        .clamp(0.0, double.infinity)
        .toDouble();
    final scrollController = useScrollController(
      initialScrollOffset: initialScrollOffset,
    );

    return GlassContainer(
      useOwnLayer: true,
      width: 280,
      quality: GlassQuality.premium,
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
      shape: const LiquidRoundedSuperellipse(borderRadius: 28),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 2, bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    source.name.isEmpty ? '选集' : source.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GlassIconButton(
                  useOwnLayer: true,
                  icon: const Icon(CupertinoIcons.xmark, size: 18),
                  onPressed: onClose,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.zero,
              itemExtent: tileHeight,
              itemCount: source.episodes.length,
              itemBuilder: (context, index) {
                final episode = source.episodes[index];
                final selected = index == episodeIndex;
                return Semantics(
                  selected: selected,
                  child: GlassListTile(
                    leading: Icon(
                      selected
                          ? CupertinoIcons.play_fill
                          : CupertinoIcons.play,
                      size: 17,
                    ),
                    title: Text(
                      episode.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    titleStyle: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 16,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                    onTap: () => onSelected(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
