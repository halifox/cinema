import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';
import '../../../shared/presentation/hooks/glass_large_title_hook.dart';
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
    final titleController = useGlassLargeTitleController();
    return GlassScaffold(
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      appBar: GlassAppBar(
        title: Text(
          '搜索结果',
          style: TextStyle(
            color: CupertinoColors.label.resolveFrom(context),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        largeTitleController: titleController,
        leading: Semantics(
          button: true,
          label: '返回',
          child: GlassIconButton(
            icon: const Icon(CupertinoIcons.chevron_back),
            useOwnLayer: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: titleController.scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          GlassLargeTitle(
            text: query,
            controller: titleController,
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.paddingOf(context).top + 44,
              24,
              8,
            ),
          ),
          CupertinoPagingSliverView<VodItem>(
            state: ref.watch(provider),
            onLoadNext: () => ref.read(provider.notifier).loadNext(),
            onRetry: () => ref.read(provider.notifier).forceRefresh(),
            contentBuilder: (data, widgetCount, endItemView) {
              if (data.items.isEmpty) {
                return ContentStateSliver.empty(
                  icon: CupertinoIcons.search,
                  title: '没有找到相关影片',
                  message: '没有与“$query”匹配的结果',
                );
              }
              return VodGridSliver(items: data.items, endItem: endItemView);
            },
          ),
        ],
      ),
    );
  }
}
