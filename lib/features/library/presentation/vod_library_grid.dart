import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../cms/cms_models.dart';
import '../../../shared/presentation/widgets/content_state.dart';
import '../../../shared/presentation/widgets/vod_card.dart';

class VodLibraryGrid extends StatelessWidget {
  const VodLibraryGrid({
    required this.items,
    required this.emptyIcon,
    required this.emptyTitle,
    required this.emptyMessage,
    this.onRetry,
    super.key,
  });

  final AsyncValue<List<VodItem>> items;
  final IconData emptyIcon;
  final String emptyTitle;
  final String emptyMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return items.when(
      loading: () => const ContentStateSliver.loading(),
      error: (error, stackTrace) =>
          ContentStateSliver.error(error: error, onRetry: onRetry),
      data: (vods) {
        if (vods.isEmpty) {
          return ContentStateSliver.empty(
            icon: emptyIcon,
            title: emptyTitle,
            message: emptyMessage,
          );
        }
        return VodGridSliver(
          items: vods,
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 120),
        );
      },
    );
  }
}
