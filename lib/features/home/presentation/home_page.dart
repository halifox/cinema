import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../../shared/presentation/widgets/cupertino_paging_sliver_view.dart';
import '../../../shared/presentation/widgets/vod_card.dart';
import '../application/home_controller.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(homeCatalogProvider);
    final filterController = ref.read(homeFilterProvider.notifier);
    final scrollController = useScrollController();

    void selectPrimary({required int id}) {
      filterController.selectPrimary(id: id);
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutCubic,
        );
      }
    }

    return GlassScaffold(
      edgeToEdge: true,
      contentAwareBrightness: true,
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      topEdgeFade: true,
      bottomEdgeFade: true,
      topEdgeFadeExtent: 64,
      bottomEdgeFadeExtent: 64,
      body: CustomScrollView(
        key: const PageStorageKey('home-scroll'),
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.paddingOf(context).top + 14),
          ),
          catalog.when(
            data: (data) {
              final primaryId = data.selectedPrimaryId;
              final activeTypeId = data.activeTypeId;
              if (primaryId == null || activeTypeId == null) {
                return const ContentStateSliver.empty(
                  icon: CupertinoIcons.square_grid_2x2,
                  title: '暂无分类',
                  message: '分类接口没有返回可用内容。',
                );
              }
              return SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: CategoryRows(
                      primary: data.primary,
                      secondary: data.secondary,
                      selectedPrimaryId: primaryId,
                      selectedSecondaryId: data.selectedSecondaryId,
                      onPrimarySelected: (id) => selectPrimary(id: id),
                      onSecondarySelected: (id) {
                        if (id != null) {
                          filterController.selectSecondary(id: id);
                        }
                      },
                    ),
                  ),
                  CatalogFeed(
                    key: ValueKey(activeTypeId),
                    typeId: activeTypeId,
                  ),
                ],
              );
            },
            loading: () => const ContentStateSliver.loading(),
            error: (error, stackTrace) => ContentStateSliver.error(
              error: error,
              onRetry: () => ref.invalidate(categoriesProvider),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 104)),
        ],
      ),
    );
  }
}

class CategoryRows extends StatelessWidget {
  const CategoryRows({
    required this.primary,
    required this.secondary,
    required this.selectedPrimaryId,
    required this.selectedSecondaryId,
    required this.onPrimarySelected,
    required this.onSecondarySelected,
    super.key,
  });

  final List<CmsCategory> primary;
  final List<CmsCategory> secondary;
  final int selectedPrimaryId;
  final int? selectedSecondaryId;
  final ValueChanged<int> onPrimarySelected;
  final ValueChanged<int?> onSecondarySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryCategoryBar(
            categories: primary,
            selectedId: selectedPrimaryId,
            onSelected: onPrimarySelected,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              // 一级分类切换时，二级分类栏始终占用相同高度。只淡入淡出，
              // 避免 SizeTransition 在切换的中间帧压缩高度，带动下方列表抖动。
              child: child,
            ),
            child: secondary.isEmpty
                ? const SizedBox.shrink()
                : SizedBox(
                    width: double.infinity,
                    child: SecondaryCategoryBar(
                      key: ValueKey(selectedPrimaryId),
                      categories: secondary,
                      selectedId: selectedSecondaryId,
                      onSelected: onSecondarySelected,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class PrimaryCategoryBar extends StatelessWidget {
  const PrimaryCategoryBar({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    super.key,
  });

  final List<CmsCategory> categories;
  final int selectedId;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 22,
        children: [
          for (final item in categories)
            PrimaryCategoryButton(
              label: item.name,
              selected: item.id == selectedId,
              onPressed: () {
                if (item.id != selectedId) {
                  onSelected(item.id);
                }
              },
            ),
        ],
      ),
    );
  }
}

class PrimaryCategoryButton extends StatelessWidget {
  const PrimaryCategoryButton({
    required this.label,
    required this.selected,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme.of(context).primaryColor;
    final labelColor = CupertinoColors.label.resolveFrom(context);
    final inactiveColor = CupertinoColors.tertiaryLabel.resolveFrom(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: const Size(0, 42),
      onPressed: onPressed,
      child: SizedBox(
        height: 42,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              style: TextStyle(
                color: selected ? labelColor : inactiveColor,
                fontSize: selected ? 19 : 16,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                letterSpacing: selected ? -.45 : -.2,
              ),
              child: Text(label),
            ),
            const SizedBox(height: 7),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: selected ? 18 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryCategoryBar extends StatelessWidget {
  const SecondaryCategoryBar({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    super.key,
  });

  final List<CmsCategory> categories;
  final int? selectedId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          spacing: 4,
          children: [
            for (final item in categories)
              SecondaryCategoryButton(
                label: item.name,
                selected: item.id == selectedId,
                onPressed: () => onSelected(item.id),
              ),
          ],
        ),
      ),
    );
  }
}

class SecondaryCategoryButton extends StatelessWidget {
  const SecondaryCategoryButton({
    required this.label,
    required this.selected,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final labelColor = CupertinoColors.label.resolveFrom(context);
    final selectedForegroundColor = CupertinoColors.systemBackground
        .resolveFrom(context);
    final foregroundColor = selected
        ? selectedForegroundColor
        : CupertinoColors.secondaryLabel.resolveFrom(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      borderRadius: BorderRadius.circular(15),
      onPressed: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        constraints: const BoxConstraints(minHeight: 30),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? labelColor : const Color(0x00000000),
          borderRadius: BorderRadius.circular(15),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          style: TextStyle(
            color: foregroundColor,
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            letterSpacing: -.1,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

class CatalogFeed extends ConsumerWidget {
  const CatalogFeed({required this.typeId, super.key});

  final int typeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = catalogProvider(typeId);
    return CupertinoPagingSliverView(
      state: ref.watch(provider),
      onLoadNext: () => ref.read(provider.notifier).loadNext(),
      onRetry: () => ref.read(provider.notifier).forceRefresh(),
      contentBuilder: (data, widgetCount, endItemView) {
        if (data.items.isEmpty) {
          return const ContentStateSliver.empty(
            icon: CupertinoIcons.film,
            title: '这个分类还是空的',
            message: '可以切换其他分类看看。',
          );
        }
        return VodGridSliver(items: data.items, endItem: endItemView);
      },
    );
  }
}
