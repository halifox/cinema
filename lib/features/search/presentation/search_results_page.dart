import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../../shared/presentation/widgets/cupertino_paging_sliver_view.dart';
import '../../../shared/presentation/widgets/vod_card.dart';

class SearchResultsPage extends HookConsumerWidget {
  const SearchResultsPage({required this.query, super.key});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = searchResultsProvider(query);
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
        slivers: [
          CupertinoPagingSliverView<VodItem>(
            state: ref.watch(provider),
            onLoadNext: () => ref.read(provider.notifier).loadNext(),
            onRetry: () => ref.read(provider.notifier).forceRefresh(),
            contentBuilder: (data, widgetCount, endItemView) {
              if (data.items.isEmpty) {
                return const EmptyStateSliver(
                  title: '没有找到相关影片',
                  subtitle: '试试更短的片名或其他关键词。',
                );
              }
              return VodGridSliver(items: data.items, endItem: endItemView);
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
