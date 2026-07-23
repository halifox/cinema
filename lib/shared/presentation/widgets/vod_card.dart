import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../features/detail/presentation/vod_detail_page.dart';
import 'cached_image_feedback.dart';

class VodCard extends StatelessWidget {
  const VodCard({required this.item, super.key});

  final VodItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (routeContext) =>
                  VodDetailPage(vodId: item.id, initialItem: item),
            ),
          );
        },
        child: Hero(
          tag: 'vod-cover-${item.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(
                    context,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: item.picture,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    progressIndicatorBuilder: buildCachedImageLoading,
                    errorWidget: buildCachedImageError,
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, .12, .62, 1],
                      colors: [
                        Color(0x18000000),
                        Color(0x00000000),
                        Color(0x08000000),
                        Color(0x76000000),
                      ],
                    ),
                  ),
                ),
                if (item.remarks.isNotEmpty)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 128),
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        shape: const LiquidRoundedSuperellipse(
                          borderRadius: 26,
                        ),
                        child: Text(
                          item.remarks,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 4,
                  right: 4,
                  bottom: 4,
                  child: GlassContainer(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                    shape: const LiquidRoundedSuperellipse(borderRadius: 26),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          item.actor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xB8EBEBF5),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class VodGridSliver extends StatelessWidget {
  const VodGridSliver({
    required this.items,
    this.endItem,
    this.padding = const EdgeInsets.fromLTRB(18, 12, 18, 8),
    super.key,
  });

  final List<VodItem> items;
  final Widget? endItem;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 328 / 422,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          if (endItem != null && index == items.length) return endItem;
          return VodCard(item: items[index]);
        }, childCount: items.length + (endItem == null ? 0 : 1)),
      ),
    );
  }
}
