import 'package:cinema/cms/cms_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final vodRepositoryProvider = Provider<VodRepository>(
  (ref) => throw UnimplementedError('VodRepository must be overridden'),
);

abstract interface class VodRepository {
  Future<CmsPage<VodItem>> getCategories();

  Future<CmsPage<VodItem>> getCatalog({required int typeId, required int page});

  Future<CmsPage<VodItem>> search({required String query, required int page});

  Future<VodItem> getDetail({required int id});
}
