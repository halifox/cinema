import 'package:cinema/cms/cms_providers.dart';
import 'package:cinema/shared/presentation/hooks/glass_large_title_hook.dart';
import 'package:cinema/shared/presentation/widgets/ambient_glow_background.dart';
import 'package:cinema/shared/presentation/widgets/content_state.dart';
import 'package:cinema/shared/presentation/widgets/cupertino_paging_sliver_view.dart';
import 'package:cinema/shared/presentation/widgets/vod_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class VodCatalogPage extends HookConsumerWidget {
  const VodCatalogPage({
    required this.typeId,
    required this.title,
    super.key,
  });

  final int typeId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useGlassLargeTitleController();
    final provider = catalogProvider(typeId);

    return GlassScaffold(
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      appBar: GlassAppBar(
        title: Text(
          title,
          style: TextStyle(
            color: CupertinoColors.label.resolveFrom(context),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        largeTitleController: titleController,
        leading: GlassIconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CustomScrollView(
        controller: titleController.scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          GlassLargeTitle(
            text: title,
            controller: titleController,
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.paddingOf(context).top + 44,
              24,
              8,
            ),
          ),
          CupertinoPagingSliverView(
            state: ref.watch(provider),
            onLoadNext: () => ref.read(provider.notifier).loadNext(),
            onRetry: () => ref.read(provider.notifier).forceRefresh(),
            contentBuilder: (data, widgetCount, endItemView) {
              if (data.items.isEmpty) {
                return ContentStateSliver.empty(
                  icon: CupertinoIcons.film,
                  title: '暂无$title内容',
                  message: '这个分类暂时没有可播放的影片。',
                );
              }
              return VodGridSliver(
                items: data.items,
                endItem: endItemView,
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 32),
              );
            },
          ),
        ],
      ),
    );
  }
}
