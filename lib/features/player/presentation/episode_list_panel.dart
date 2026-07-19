import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';

class EpisodeListPanel extends HookWidget {
  const EpisodeListPanel({
    required this.source,
    required this.episodeIndex,
    required this.width,
    required this.onSelected,
    super.key,
  });

  final PlaySource source;
  final int episodeIndex;
  final double width;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    const tileHeight = 48.0;
    const indicatorInset = 2.0;
    final initialScrollOffset = (episodeIndex * tileHeight - tileHeight * 2)
        .clamp(0.0, double.infinity)
        .toDouble();
    final scrollController = useScrollController(
      initialScrollOffset: initialScrollOffset,
    );
    final hasSelection =
        episodeIndex >= 0 && episodeIndex < source.episodes.length;
    final labelColor =
        CupertinoTheme.of(context).textTheme.textStyle.color ??
        CupertinoColors.label;

    return GlassContainer(
      width: width,
      shape: const LiquidRoundedSuperellipse(borderRadius: 26),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CupertinoColors.transparent,
              CupertinoColors.black,
              CupertinoColors.black,
              CupertinoColors.transparent,
            ],
            stops: [0.0, 0.1, 0.9, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Stack(
          children: [
            if (hasSelection)
              TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: episodeIndex.toDouble(),
                  end: episodeIndex.toDouble(),
                ),
                duration: const Duration(milliseconds: 360),
                curve: Curves.easeOutBack,
                child: GlassContainer(
                  height: tileHeight - indicatorInset * 2,
                  allowElevation: true,
                  glowIntensity: .7,
                  shape: const LiquidRoundedSuperellipse(borderRadius: 14),
                  settings: const LiquidGlassSettings(
                    glassColor: Color(0x42FFFFFF),
                    thickness: 34,
                    blur: 7,
                    chromaticAberration: .16,
                    lightIntensity: 1,
                    ambientStrength: .18,
                    ambientRim: .32,
                    saturation: 1.8,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0x14FFFFFF),
                      border: Border.all(
                        color: const Color(0x70FFFFFF),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                ),
                builder: (context, animatedIndex, child) {
                  return AnimatedBuilder(
                    animation: scrollController,
                    child: child,
                    builder: (context, child) {
                      final scrollOffset = scrollController.hasClients
                          ? scrollController.offset
                          : initialScrollOffset;
                      return Positioned(
                        left: 6,
                        right: 6,
                        top:
                            4 +
                            animatedIndex * tileHeight +
                            indicatorInset -
                            scrollOffset,
                        child: IgnorePointer(child: child),
                      );
                    },
                  );
                },
              ),
            ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(4),
              itemExtent: tileHeight,
              itemCount: source.episodes.length,
              itemBuilder: (context, index) {
                final episode = source.episodes[index];
                final selected = index == episodeIndex;
                return Semantics(
                  selected: selected,
                  child: GlassListTile(
                    title: Text(
                      episode.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    titleStyle: TextStyle(
                      color: labelColor,
                      fontSize: 16,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    onTap: () => onSelected(index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
