import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/content_state.dart';
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
                '光影',
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
                return const EmptyStateSliver(
                  title: '暂无分类',
                  subtitle: '分类接口没有返回可用内容。',
                );
              }
              final primaryId = selectedPrimaryId.value ?? primary.first.id;
              final secondary = data.categories
                  .where((item) => item.parentId == primaryId)
                  .toList(growable: false);
              final activeTypeId = selectedSecondaryId.value ?? primaryId;
              return SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: CategoryRows(
                      primary: primary,
                      secondary: secondary,
                      selectedPrimaryId: primaryId,
                      selectedSecondaryId: selectedSecondaryId.value,
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
            loading: () => const ContentLoadingSliver(),
            error: (error, stackTrace) => ContentErrorSliver(
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
              GlassChip(
                icon: Icon(
                  selectedSecondaryId == null
                      ? CupertinoIcons.checkmark_circle_fill
                      : CupertinoIcons.circle,
                ),
                label: '全部',
                selected: selectedSecondaryId == null,
                onTap: () => onSecondarySelected(null),
              ),
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

class CatalogFeed extends HookConsumerWidget {
  const CatalogFeed({required this.typeId, super.key});

  final int typeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadedPageCount = useState(1);
    final pages = [
      for (var page = 1; page <= loadedPageCount.value; page++)
        ref.watch(catalogPageProvider((typeId: typeId, page: page))),
    ];
    final first = pages.first;
    if (first.isLoading) return const ContentLoadingSliver();
    if (first.hasError) {
      return ContentErrorSliver(
        error: first.error!,
        onRetry: () =>
            ref.invalidate(catalogPageProvider((typeId: typeId, page: 1))),
      );
    }
    if (first.value?.items.isEmpty ?? true) {
      return const EmptyStateSliver(title: '这个分类还是空的', subtitle: '可以切换其他分类看看。');
    }

    final last = pages.last;
    final hasMore = last.value?.hasMore ?? true;
    return SliverMainAxisGroup(
      slivers: [
        for (var index = 0; index < pages.length; index++)
          ...buildCatalogPageSlivers(
            context: context,
            ref: ref,
            page: pages[index],
            typeId: typeId,
            pageNumber: index + 1,
          ),
        if (hasMore)
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: GlassButton.custom(
                  width: 140,
                  height: 46,
                  enabled: !last.isLoading,
                  onTap: () => loadedPageCount.value++,
                  child: last.isLoading
                      ? const GlassProgressIndicator.circular(size: 24)
                      : const Text('加载更多'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

List<Widget> buildCatalogPageSlivers({
  required BuildContext context,
  required WidgetRef ref,
  required AsyncValue<CmsPage<VodItem>> page,
  required int typeId,
  required int pageNumber,
}) {
  if (page.hasValue) return [VodGridSliver(items: page.value!.items)];
  if (page.hasError) {
    return [
      SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GlassButton.custom(
              width: 150,
              height: 44,
              onTap: () => ref.invalidate(
                catalogPageProvider((typeId: typeId, page: pageNumber)),
              ),
              child: const Text('加载失败，重试'),
            ),
          ),
        ),
      ),
    ];
  }
  return const [
    SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(22),
        child: Center(child: GlassProgressIndicator.circular(size: 28)),
      ),
    ),
  ];
}
