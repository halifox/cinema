import 'package:cinema/features/vod/domain/vod_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_paging_utils/riverpod_paging_utils.dart';

import 'cms_models.dart';

final categoriesProvider = FutureProvider((ref) async {
  return ref.watch(vodRepositoryProvider).getCategories();
});

final catalogProvider =
    AsyncNotifierProvider
        .family<CatalogNotifier, PagePagingData<VodItem>, int>(
          CatalogNotifier.new,
        );

class CatalogNotifier extends AsyncNotifier<PagePagingData<VodItem>>
    with PagePagingNotifierMixin<VodItem> {
  CatalogNotifier(this.typeId);

  final int typeId;

  @override
  Future<PagePagingData<VodItem>> build() => fetch(page: 1);

  @override
  Future<PagePagingData<VodItem>> fetch({required int page}) async {
    final result = await ref
        .read(vodRepositoryProvider)
        .getCatalog(typeId: typeId, page: page);
    return PagePagingData(
      items: result.items,
      hasMore: result.hasMore,
      page: page,
    );
  }
}

final searchResultsProvider =
    AsyncNotifierProvider
        .family<
          SearchResultsNotifier,
          PagePagingData<VodItem>,
          String
        >(SearchResultsNotifier.new);

class SearchResultsNotifier extends AsyncNotifier<PagePagingData<VodItem>>
    with PagePagingNotifierMixin<VodItem> {
  SearchResultsNotifier(this.query);

  final String query;

  @override
  Future<PagePagingData<VodItem>> build() => fetch(page: 1);

  @override
  Future<PagePagingData<VodItem>> fetch({required int page}) async {
    final result = await ref
        .read(vodRepositoryProvider)
        .search(query: query, page: page);
    return PagePagingData(
      items: result.items,
      hasMore: result.hasMore,
      page: page,
    );
  }
}

typedef VodDetailArguments = ({int id, VodItem? initialItem});

final vodDetailProvider =
    StreamProvider.family<VodItem, VodDetailArguments>(
      (ref, arguments) {
        final repository = ref.watch(vodRepositoryProvider);
        return streamVodDetail(
          repository: repository,
          arguments: arguments,
        );
      },
    );

Stream<VodItem> streamVodDetail({
  required VodRepository repository,
  required VodDetailArguments arguments,
}) async* {
  final initialItem = arguments.initialItem;
  if (initialItem != null) {
    yield initialItem;
  }

  try {
    yield await repository.getDetail(id: arguments.id);
  } on Object {
    if (initialItem == null) rethrow;
  }
}
