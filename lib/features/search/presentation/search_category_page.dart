import 'dart:ui';

import 'package:cinema/cms/cms_models.dart';
import 'package:cinema/cms/cms_providers.dart';
import 'package:cinema/features/catalog/presentation/vod_catalog_page.dart';
import 'package:cinema/shared/presentation/widgets/ambient_glow_background.dart';
import 'package:cinema/shared/presentation/widgets/content_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class SearchCategoryPage extends HookConsumerWidget {
  const SearchCategoryPage({
    required this.titleController,
    required this.onDismiss,
    super.key,
  });

  final GlassLargeTitleController titleController;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        onDismiss();
      },
      child: GlassScaffold(
        edgeToEdge: true,
        contentAwareBrightness: true,
        statusBarStyle: GlassStatusBarStyle.auto,
        background: const AmbientGlowBackground(),
        topEdgeFade: true,
        bottomEdgeFade: true,
        topEdgeFadeExtent: 64,
        bottomEdgeFadeExtent: 64,
        headerScrollController: titleController.scrollController,
        body: CustomScrollView(
          controller: titleController.scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            GlassLargeTitle(
              text: '搜索',
              controller: titleController,
              padding: EdgeInsets.fromLTRB(
                16,
                MediaQuery.paddingOf(context).top + 16,
                16,
                8,
              ),
            ),
            ref.watch(categoriesProvider).when(
              data: (page) {
                final categories = categoryEntries(
                  categories: page.categories,
                );
                if (categories.isEmpty) {
                  return const ContentStateSliver.empty(
                    icon: CupertinoIcons.square_grid_2x2,
                    title: '暂无分类',
                    message: '分类接口没有返回可用内容。',
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                  sliver: SliverGrid.builder(
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.65,
                        ),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return VodCategoryCard(
                        category: category,
                        color: vodCategoryColor(
                          context: context,
                          seed: category.id,
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const ContentStateSliver.loading(),
              error: (error, stackTrace) => ContentStateSliver.error(
                error: error,
                onRetry: () => ref.invalidate(categoriesProvider),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<CmsCategory> categoryEntries({
  required List<CmsCategory> categories,
}) {
  final children = categories
      .where((category) => category.parentId != 0)
      .toList(growable: false);
  return children.isEmpty ? categories : children;
}

Color vodCategoryColor({
  required BuildContext context,
  required int seed,
}) {
  final hue = (seed * 0.618033988749895 * 360) % 360;
  return CupertinoDynamicColor.withBrightness(
    color: HSLColor.fromAHSL(1, hue, .58, .74).toColor(),
    darkColor: HSLColor.fromAHSL(1, hue, .58, .74).toColor(),
  ).resolveFrom(context);
}

class VodCategoryCard extends StatelessWidget {
  const VodCategoryCard({
    required this.category,
    required this.color,
    super.key,
  });

  final CmsCategory category;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (routeContext) => VodCatalogPage(
            typeId: category.id,
            title: category.name,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ColoredBox(
          color: color,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GlassContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: CupertinoColors.label.resolveFrom(context),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
