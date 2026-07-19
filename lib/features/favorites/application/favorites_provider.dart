import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../cms/cms_models.dart';
import '../../library/data/library_database.dart';

final favoritesProvider = StreamProvider<List<VodItem>>((ref) {
  return ref.watch(libraryDatabaseProvider).watchFavoriteVods();
});

final vodFavoriteProvider = StreamProvider.family<bool, int>((ref, vodId) {
  return ref.watch(libraryDatabaseProvider).watchFavorite(vodId: vodId);
});
