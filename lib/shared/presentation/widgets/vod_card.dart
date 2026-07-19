import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

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
          CupertinoPageRoute<void>(
            builder: (routeContext) =>
                VodDetailPage(vodId: item.id, initialItem: item),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: 'vod-cover-${item.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(
                      color: CupertinoColors.secondarySystemBackground
                          .resolveFrom(context),
                      child: item.picture.isEmpty
                          ? buildCachedImageError(
                              context,
                              '',
                              StateError('empty'),
                            )
                          : CachedNetworkImage(
                              imageUrl: item.picture,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: buildCachedImageLoading,
                              errorWidget: buildCachedImageError,
                            ),
                    ),
                    if (item.remarks.isNotEmpty)
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 8,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color(0xC8202020),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 4,
                              ),
                              child: Text(
                                item.remarks,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: CupertinoColors.label.resolveFrom(context),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            [
              if (item.year.isNotEmpty) item.year,
              if (item.displayScore.isNotEmpty) '豆瓣 ${item.displayScore}',
            ].join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class VodGridSliver extends StatelessWidget {
  const VodGridSliver({required this.items, super.key});

  final List<VodItem> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 18,
          childAspectRatio: .56,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => VodCard(item: items[index]),
          childCount: items.length,
        ),
      ),
    );
  }
}
