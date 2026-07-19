import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../shared/presentation/hooks/glass_large_title_hook.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../library/application/library_providers.dart';
import '../../library/presentation/vod_library_grid.dart';

class VodHistoryPage extends HookConsumerWidget {
  const VodHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useGlassLargeTitleController();
    final history = ref.watch(vodHistoryProvider);

    return GlassScaffold(
      edgeToEdge: true,
      contentAwareBrightness: true,
      statusBarStyle: GlassStatusBarStyle.auto,
      background: const AmbientGlowBackground(),
      topEdgeFade: true,
      bottomEdgeFade: true,
      topEdgeFadeExtent: 64,
      bottomEdgeFadeExtent: 64,
      headerScrollController: titleController.scrollController,
      appBar: GlassAppBar(
        title: const Text('历史'),
        centerTitle: false,
        largeTitleController: titleController,
        leading: Semantics(
          button: true,
          label: '返回',
          child: GlassIconButton(
            icon: const Icon(CupertinoIcons.chevron_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Semantics(
            button: true,
            label: '清空观看历史',
            child: GlassIconButton(
              icon: const Icon(
                CupertinoIcons.trash,
                color: CupertinoColors.systemRed,
              ),
              onPressed: () async {
                final shouldClear = await GlassDialog.show<bool>(
                  context: context,
                  title: '清空历史？',
                  message: '此操作无法撤销。',
                  actions: [
                    GlassDialogAction(
                      label: '取消',
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    GlassDialogAction(
                      label: '清空',
                      isDestructive: true,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                );
                if (shouldClear != true || !context.mounted) return;
                await ref
                    .read(libraryCommandsProvider)
                    .clearViewingHistory();
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: titleController.scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          GlassLargeTitle(
            text: '历史',
            controller: titleController,
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.paddingOf(context).top + 56,
              16,
              8,
            ),
          ),
          VodLibraryGrid(
            items: history,
            emptyIcon: CupertinoIcons.clock,
            emptyTitle: '暂无观看历史',
            emptyMessage: '播放过的影片会显示在这里',
            onRetry: () => ref.invalidate(vodHistoryProvider),
          ),
        ],
      ),
    );
  }
}
