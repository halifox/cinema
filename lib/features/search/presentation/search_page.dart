import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../../shared/presentation/hooks/glass_large_title_hook.dart';
import '../../../shared/presentation/widgets/ambient_glow_background.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../library/application/library_providers.dart';
import 'search_results_page.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({required this.onDismiss, super.key});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useGlassLargeTitleController();

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
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onDismiss();
        },
        child: SearchHistory(titleController: titleController),
      ),
    );
  }
}

class SearchHistory extends ConsumerWidget {
  const SearchHistory({required this.titleController, super.key});

  final GlassLargeTitleController titleController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(searchHistoryProvider);
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    return CustomScrollView(
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
        ...history.when(
          data: (items) => [
            if (items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: keyboardHeight + 50),
                  child: const SearchHistoryEmptyState(),
                ),
              )
            else
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    18,
                    16,
                    18,
                    MediaQuery.paddingOf(context).bottom +
                        keyboardHeight +
                        72,
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
              ),
          ],
          loading: () => [const ContentStateSliver.loading()],
          error: (error, stackTrace) => [
            ContentStateSliver.error(
              error: error,
              onRetry: () => ref.invalidate(searchHistoryProvider),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchHistoryEmptyState extends StatelessWidget {
  const SearchHistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.search,
            size: 64,
            color: CupertinoColors.tertiaryLabel.resolveFrom(context),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无最近搜索',
            style: TextStyle(
              color: CupertinoColors.label.resolveFrom(context),
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '你的最近搜索记录会显示在这里。',
            style: TextStyle(
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
