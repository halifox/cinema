import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_paging_utils/riverpod_paging_utils.dart';

import 'cms_api.dart';
import 'cms_models.dart';

final cmsDioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://example.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {'Accept': 'application/json'},
      validateStatus: (status) => status == 200,
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse: (response, handler) {
        final data = response.data;
        if (data is! String) {
          handler.next(response);
          return;
        }

        try {
          response.data = jsonDecode(data);
          handler.next(response);
        } on FormatException catch (error) {
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
              error: error,
              message: 'CMS 返回的内容不是有效 JSON',
            ),
          );
        }
      },
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
  }
  ref.onDispose(() => dio.close(force: true));
  return dio;
});

final cmsApiProvider = Provider<CmsApi>((ref) {
  return CmsApi(ref.watch(cmsDioProvider));
});

final categoriesProvider = FutureProvider<CmsPage<VodItem>>((ref) async {
  final response = await ref.watch(cmsApiProvider).categories();
  return response.toPage(includeCategories: true);
});

final catalogProvider =
    AsyncNotifierProvider.autoDispose
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
    final response = await ref
        .read(cmsApiProvider)
        .catalog(typeId: typeId, page: page);
    final result = response.toPage();
    return PagePagingData(
      items: result.items,
      hasMore: result.hasMore,
      page: page,
    );
  }
}

final searchResultsProvider =
    AsyncNotifierProvider.autoDispose
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
    final response = await ref
        .read(cmsApiProvider)
        .search(query: query, page: page);
    final result = response.toPage();
    return PagePagingData(
      items: result.items,
      hasMore: result.hasMore,
      page: page,
    );
  }
}

typedef VodDetailArguments = ({int id, VodItem? initialItem});

final vodDetailProvider =
    StreamProvider.autoDispose.family<VodItem, VodDetailArguments>(
      (ref, arguments) {
        final api = ref.watch(cmsApiProvider);
        return streamVodDetail(api: api, arguments: arguments);
      },
    );

Stream<VodItem> streamVodDetail({
  required CmsApi api,
  required VodDetailArguments arguments,
}) async* {
  final initialItem = arguments.initialItem;
  if (initialItem != null) {
    yield initialItem;
  }

  try {
    final response = await api.detail(id: arguments.id);
    final page = response.toPage();
    if (page.items.isEmpty) throw StateError('没有找到该影片');
    yield page.items.first;
  } on Object {
    if (initialItem == null) rethrow;
  }
}
