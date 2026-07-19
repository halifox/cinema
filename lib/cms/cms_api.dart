import 'package:dio/dio.dart';

import 'cms_models.dart';

class CmsApi {
  const CmsApi({required this.dio});

  final Dio dio;

  Future<CmsPage<VodItem>> categories() async {
    final json = await getJson(
      path: '/api.php/provide/vod/',
      query: {'ac': 'list', 'pg': 1},
    );
    return parsePage(json: json, includeCategories: true);
  }

  Future<CmsPage<VodItem>> catalog({
    required int typeId,
    required int page,
  }) async {
    final json = await getJson(
      path: '/api.php/provide/vod/at/json/',
      query: {'ac': 'detail', 't': typeId, 'pg': page},
    );
    return parsePage(json: json);
  }

  Future<CmsPage<VodItem>> search({
    required String query,
    required int page,
  }) async {
    final json = await getJson(
      path: '/api.php/provide/vod/at/json/',
      query: {'ac': 'detail', 'wd': query, 'pg': page},
    );
    return parsePage(json: json);
  }

  Future<VodItem> detail({required int id}) async {
    final json = await getJson(
      path: '/api.php/provide/vod/at/json/',
      query: {'ac': 'detail', 'ids': id},
    );
    final page = parsePage(json: json);
    if (page.items.isEmpty) {
      throw StateError('没有找到该影片');
    }
    return page.items.first;
  }

  Future<Map<String, dynamic>> getJson({
    required String path,
    required Map<String, Object> query,
  }) async {
    final response = await dio.get<Object>(path, queryParameters: query);
    final data = response.data;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw const FormatException('CMS 返回了无法识别的数据');
  }

  CmsPage<VodItem> parsePage({
    required Map<String, dynamic> json,
    bool includeCategories = false,
  }) {
    if (jsonInt(json['code']) != 1) {
      throw StateError(
        jsonText(json['msg']).isEmpty ? '请求失败' : jsonText(json['msg']),
      );
    }
    final rawItems = json['list'];
    final rawCategories = json['class'];
    return CmsPage<VodItem>(
      page: jsonInt(json['page']),
      pageCount: jsonInt(json['pagecount']),
      total: jsonInt(json['total']),
      items: rawItems is List
          ? rawItems
                .whereType<Map>()
                .map(
                  (item) => VodItem.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList(growable: false)
          : const [],
      categories: includeCategories && rawCategories is List
          ? rawCategories
                .whereType<Map>()
                .map(
                  (item) =>
                      CmsCategory.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList(growable: false)
          : const [],
    );
  }
}
