import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../../shared/presentation/widgets/vod_card.dart';

class SearchResultsPage extends HookConsumerWidget {
  const SearchResultsPage({required this.query, super.key});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadedPageCount = useState(1);
    final pages = [
      for (var page = 1; page <= loadedPageCount.value; page++)
        ref.watch(searchPageProvider((query: query, page: page))),
    ];
    final first = pages.first;
    return GlassScaffold(
      edgeToEdge: true,
      contentAwareBrightness: true,
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      appBar: GlassAppBar(
        title: Text(query),
        leading: GlassIconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          useOwnLayer: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: buildSearchSlivers(
          context: context,
          ref: ref,
          pages: pages,
          loadedPageCount: loadedPageCount,
        ),
      ),
    );
  }
}

List<Widget> buildSearchSlivers({
  required BuildContext context,
  required WidgetRef ref,
  required List<AsyncValue<CmsPage<VodItem>>> pages,
  required ValueNotifier<int> loadedPageCount,
}) {
  final first = pages.first;
  if (first.isLoading) return const [ContentLoadingSliver()];
  if (first.hasError) {
    return [
      ContentErrorSliver(
        error: first.error!,
        onRetry: () => ref.invalidate(searchPageProvider),
      ),
    ];
  }
  if (first.value?.items.isEmpty ?? true) {
    return const [
      EmptyStateSliver(title: '没有找到相关影片', subtitle: '试试更短的片名或其他关键词。'),
    ];
  }
  final last = pages.last;
  return [
    for (final page in pages)
      if (page.hasValue) VodGridSliver(items: page.value!.items),
    if (last.value?.hasMore ?? true)
      SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
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
  ];
}
