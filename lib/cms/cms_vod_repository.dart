import 'package:cinema/features/vod/domain/vod_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cms_client_providers.dart';
import 'cms_models.dart';

final cmsVodRepositoryProvider = Provider((ref) => CmsVodRepository(ref: ref));

class CmsVodRepository implements VodRepository {
  CmsVodRepository({required this.ref});

  final Ref ref;

  @override
  Future<CmsPage<VodItem>> getCategories() async {
    final response = await ref.read(cmsApiProvider).categories();
    return response.toPage(includeCategories: true);
  }

  @override
  Future<CmsPage<VodItem>> getCatalog({
    required int typeId,
    required int page,
  }) async {
    final response = await ref
        .read(cmsApiProvider)
        .catalog(typeId: typeId, page: page);
    return response.toPage();
  }

  @override
  Future<CmsPage<VodItem>> search({
    required String query,
    required int page,
  }) async {
    final response = await ref
        .read(cmsApiProvider)
        .search(query: query, page: page);
    return response.toPage();
  }

  @override
  Future<VodItem> getDetail({required int id}) async {
    final response = await ref.read(cmsApiProvider).detail(id: id);
    final page = response.toPage();
    if (page.items.isEmpty) {
      throw StateError('没有找到该影片');
    }
    return page.items.first;
  }
}
