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

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryPage = ref.watch(categoriesProvider);
    final selectedPrimaryId = useState<int?>(null);
    final selectedSecondaryId = useState<int?>(null);
    final scrollController = useScrollController();

    return GlassScaffold(
      edgeToEdge: true,
      contentAwareBrightness: true,
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      topEdgeFade: true,
      bottomEdgeFade: true,
      topEdgeFadeExtent: 48,
      bottomEdgeFadeExtent: 72,
      body: CustomScrollView(
        key: const PageStorageKey<String>('home-scroll'),
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.paddingOf(context).top + 18,
                20,
                12,
              ),
              child: Text(
                'comics',
                style: TextStyle(
                  color: CupertinoColors.label.resolveFrom(context),
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.2,
                ),
              ),
            ),
          ),
          categoryPage.when(
            data: (data) {
              final primary = data.categories
                  .where((item) => item.parentId == 0)
                  .toList(growable: false);
              if (primary.isEmpty) {
                return const ContentStateSliver.empty(
                  icon: CupertinoIcons.square_grid_2x2,
                  title: '暂无分类',
                  message: '分类接口没有返回可用内容。',
                );
              }
              final primaryId = selectedPrimaryId.value ?? primary.first.id;
              final secondary = data.categories
                  .where((item) => item.parentId == primaryId)
                  .toList(growable: false);
              final effectiveSecondaryId =
                  selectedSecondaryId.value ??
                  (secondary.isEmpty ? null : secondary.first.id);
              final activeTypeId = effectiveSecondaryId ?? primaryId;
              return SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: CategoryRows(
                      primary: primary,
                      secondary: secondary,
                      selectedPrimaryId: primaryId,
                      selectedSecondaryId: effectiveSecondaryId,
                      onPrimarySelected: (id) {
                        selectedPrimaryId.value = id;
                        selectedSecondaryId.value = null;
                        if (scrollController.hasClients) {
                          scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 380),
                            curve: Curves.easeOutCubic,
                          );
                        }
                      },
                      onSecondarySelected: (id) {
                        selectedSecondaryId.value = id;
                      },
                    ),
                  ),
                  CatalogFeed(
                    key: ValueKey<int>(activeTypeId),
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryScroller(
            children: [
              for (final item in primary)
                GlassChip(
                  icon: Icon(
                    item.id == selectedPrimaryId
                        ? CupertinoIcons.checkmark_circle_fill
                        : CupertinoIcons.circle,
                  ),
                  label: item.name,
                  selected: item.id == selectedPrimaryId,
                  onTap: () => onPrimarySelected(item.id),
                ),
            ],
          ),
          const SizedBox(height: 10),
          CategoryScroller(
            children: [
              for (final item in secondary)
                GlassChip(
                  icon: Icon(
                    item.id == selectedSecondaryId
                        ? CupertinoIcons.checkmark_circle_fill
                        : CupertinoIcons.circle,
                  ),
                  label: item.name,
                  selected: item.id == selectedSecondaryId,
                  onTap: () => onSecondarySelected(item.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryScroller extends StatelessWidget {
  const CategoryScroller({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(spacing: 8, children: children),
    );
  }
}

class CatalogFeed extends ConsumerWidget {
  const CatalogFeed({required this.typeId, super.key});

  final int typeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = catalogProvider(typeId);
    return CupertinoPagingSliverView<VodItem>(
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
