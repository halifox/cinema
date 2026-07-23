import 'dart:async';

import 'package:cinema/features/library/application/library_providers.dart';
import 'package:cinema/features/search/presentation/search_results_page.dart';
import 'package:cinema/shared/presentation/widgets/ambient_glow_background.dart';
import 'package:cinema/shared/presentation/widgets/content_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class SearchHistoryPage extends HookConsumerWidget {
  const SearchHistoryPage({
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
                24,
                MediaQuery.paddingOf(context).top + 16,
                24,
                8,
              ),
            ),
            ref
                .watch(searchHistoryProvider)
                .when(
                  data: (items) {
                    if (items.isEmpty) {
                      return const ContentStateSliver.empty(
                        icon: CupertinoIcons.search,
                        title: '暂无最近搜索',
                        message: '你的最近搜索记录会显示在这里。',
                      );
                    }
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          18,
                          16,
                          18,
                          MediaQuery.viewInsetsOf(context).bottom + 72,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GlassGroupedSection(
                            margin: EdgeInsets.zero,
                            shape: const LiquidRoundedSuperellipse(
                              borderRadius: 28,
                            ),
                            children: [
                              for (final query in items.reversed)
                                GlassListTile(
                                  title: Text(
                                    query,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                    top: 6,
                                    bottom: 6,
                                    left: 26,
                                    right: 6,
                                  ),
                                  titleStyle: TextStyle(
                                    color: CupertinoColors.label.resolveFrom(
                                      context,
                                    ),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onTap: () {
                                    unawaited(
                                      ref
                                          .read(libraryCommandsProvider)
                                          .recordSearch(query: query),
                                    );
                                    Navigator.of(context).push(
                                      CupertinoPageRoute<void>(
                                        builder: (routeContext) =>
                                            SearchResultsPage(query: query),
                                      ),
                                    );
                                  },
                                  trailing: GlassIconButton(
                                    icon: const Icon(
                                      CupertinoIcons.trash,
                                      color: CupertinoColors.systemRed,
                                    ),
                                    onPressed: () => unawaited(
                                      ref
                                          .read(libraryCommandsProvider)
                                          .removeSearch(query: query),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  loading: () => const ContentStateSliver.loading(),
                  error: (error, stackTrace) => ContentStateSliver.error(
                    error: error,
                    onRetry: () => ref.invalidate(searchHistoryProvider),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
