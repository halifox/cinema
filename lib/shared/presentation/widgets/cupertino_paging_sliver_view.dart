import 'package:cinema/shared/presentation/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:riverpod_paging_utils/riverpod_paging_utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'content_state.dart';

class CupertinoPagingSliverView<Item> extends StatelessWidget {
  const CupertinoPagingSliverView({
    required this.state,
    required this.onLoadNext,
    required this.onRetry,
    required this.contentBuilder,
    super.key,
  });

  final AsyncValue<PagePagingData<Item>> state;
  final VoidCallback onLoadNext;
  final VoidCallback onRetry;
  final Widget Function(
    PagePagingData<Item> data,
    int widgetCount,
    Widget endItemView,
  )
  contentBuilder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      data: (data) =>
          contentBuilder(data, data.items.length + 1, buildEndItem(data: data)),
      loading: () => const ContentStateSliver.loading(),
      error: (error, stackTrace) =>
          ContentStateSliver.error(error: error, onRetry: onRetry),
    );
  }

  Widget buildEndItem({required PagePagingData<Item> data}) {
    if (!data.hasMore) return const SizedBox.shrink();

    return switch (data.loadNextStatus) {
      LoadNextStatus.idle => VisibilityDetector(
        key: ValueKey('paging-end-${data.items.length}'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > .1) onLoadNext();
        },
        child: const PagingLoadingIndicator(),
      ),
      LoadNextStatus.loading => const PagingLoadingIndicator(),
      LoadNextStatus.error => Center(
        child: GlassButton.custom(
          width: 132,
          height: 44,
          shape: const LiquidRoundedSuperellipse(borderRadius: 44),
          onTap: onLoadNext,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.refresh, size: 18),
              SizedBox(width: 8),
              Text('重试'),
            ],
          ),
        ),
      ),
    };
  }
}

class PagingLoadingIndicator extends StatelessWidget {
  const PagingLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GlassProgressIndicator.circular(
          size: 32,
          color: CupertinoTheme.of(context).primaryColor,
        ),
      ),
    );
  }
}
