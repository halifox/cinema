import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

typedef CatalogRequest = ({int typeId, int page});

final catalogPageProvider =
    FutureProvider.family<CmsPage<VodItem>, CatalogRequest>((
      ref,
      request,
    ) async {
      final response = await ref
          .watch(cmsApiProvider)
          .catalog(typeId: request.typeId, page: request.page);
      return response.toPage();
    });

typedef SearchRequest = ({String query, int page});

final searchPageProvider =
    FutureProvider.family<CmsPage<VodItem>, SearchRequest>((
      ref,
      request,
    ) async {
      final response = await ref
          .watch(cmsApiProvider)
          .search(query: request.query, page: request.page);
      return response.toPage();
    });

final vodDetailProvider = FutureProvider.family<VodItem, int>((ref, id) async {
  final response = await ref.watch(cmsApiProvider).detail(id: id);
  final page = response.toPage();
  if (page.items.isEmpty) throw StateError('没有找到该影片');
  return page.items.first;
});
