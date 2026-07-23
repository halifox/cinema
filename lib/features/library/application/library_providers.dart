import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../cms/cms_models.dart';
import '../data/library_database.dart';

final searchHistoryProvider = StreamProvider((ref) {
  return ref.watch(libraryDatabaseProvider).watchSearchHistory();
});

final favoritesProvider = StreamProvider((ref) {
  return ref.watch(libraryDatabaseProvider).watchFavoriteVods();
});

final vodFavoriteProvider = StreamProvider.family<bool, int>((
  ref,
  vodId,
) {
  return ref.watch(libraryDatabaseProvider).watchFavorite(vodId: vodId);
});

final vodHistoryProvider = StreamProvider((ref) {
  return ref.watch(libraryDatabaseProvider).watchViewingHistory();
});

final vodViewingProgressProvider = StreamProvider
    .family<VodViewingProgress?, int>((ref, vodId) {
      return ref
          .watch(libraryDatabaseProvider)
          .watchViewingProgress(vodId: vodId);
    });

final libraryCommandsProvider = Provider((ref) {
  return LibraryCommands(database: ref.watch(libraryDatabaseProvider));
});

class LibraryCommands {
  const LibraryCommands({required this.database});

  final LibraryDatabase database;

  Future<void> recordSearch({required String query}) {
    return database.recordSearch(query: query);
  }

  Future<void> removeSearch({required String query}) {
    return database.removeSearch(query: query);
  }

  Future<void> toggleFavorite({required VodItem item}) {
    return database.toggleFavorite(item: item);
  }

  Future<void> clearViewingHistory() {
    return database.clearViewingHistory();
  }

  Future<void> recordViewing({
    required VodItem item,
    required PlaySource source,
    required PlayEpisode episode,
    required int positionMilliseconds,
  }) {
    return database.recordViewing(
      item: item,
      source: source,
      episode: episode,
      positionMilliseconds: positionMilliseconds,
    );
  }
}
