import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../cms/cms_models.dart';

part 'library_database.g.dart';

final libraryDatabaseProvider = Provider<LibraryDatabase>((ref) {
  final database = LibraryDatabase();
  ref.onDispose(database.close);
  return database;
});

class StoredVods extends Table {
  IntColumn get id => integer()();

  IntColumn get typeId => integer()();

  IntColumn get parentTypeId => integer()();

  TextColumn get name => text()();

  TextColumn get typeName => text()();

  TextColumn get picture => text()();

  TextColumn get remarks => text()();

  TextColumn get year => text()();

  TextColumn get area => text()();

  TextColumn get language => text()();

  TextColumn get score => text()();

  TextColumn get doubanScore => text()();

  TextColumn get actor => text()();

  TextColumn get director => text()();

  TextColumn get category => text()();

  TextColumn get summary => text()();

  TextColumn get duration => text()();

  TextColumn get playFrom => text()();

  TextColumn get playUrl => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class VodFavorites extends Table {
  IntColumn get vodId =>
      integer().references(StoredVods, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {vodId};
}

class VodViewingHistories extends Table {
  IntColumn get vodId =>
      integer().references(StoredVods, #id, onDelete: KeyAction.cascade)();

  TextColumn get sourceName => text()();

  TextColumn get episodeName => text()();

  TextColumn get episodeUrl => text()();

  DateTimeColumn get watchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {vodId};
}

class SearchHistories extends Table {
  TextColumn get normalizedQuery => text()();

  TextColumn get query => text()();

  DateTimeColumn get searchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {normalizedQuery};
}

@DriftDatabase(
  tables: [StoredVods, VodFavorites, VodViewingHistories, SearchHistories],
)
class LibraryDatabase extends _$LibraryDatabase {
  LibraryDatabase() : super(driftDatabase(name: 'cinema_library'));

  static const maximumSearchHistoryEntries = 12;

  @override
  int get schemaVersion => 1;

  Stream<List<String>> watchSearchHistory() {
    final query = select(searchHistories)
      ..orderBy([(row) => OrderingTerm.desc(row.searchedAt)]);
    return query.watch().map(
      (entries) => entries.map((entry) => entry.query).toList(growable: false),
    );
  }

  Future<void> recordSearch({required String query}) async {
    final value = query.trim();
    final normalizedQuery = value.toLowerCase();
    if (normalizedQuery.isEmpty) return;

    await transaction(() async {
      await into(searchHistories).insertOnConflictUpdate(
        SearchHistoriesCompanion.insert(
          normalizedQuery: normalizedQuery,
          query: value,
          searchedAt: DateTime.now(),
        ),
      );

      final overflow = await (select(searchHistories)
            ..orderBy([(row) => OrderingTerm.desc(row.searchedAt)])
            ..limit(1000, offset: maximumSearchHistoryEntries))
          .get();
      if (overflow.isNotEmpty) {
        await (delete(searchHistories)..where(
              (row) => row.normalizedQuery.isIn(
                overflow.map((entry) => entry.normalizedQuery),
              ),
            ))
            .go();
      }
    });
  }

  Future<void> removeSearch({required String query}) {
    return (delete(searchHistories)..where(
          (row) => row.normalizedQuery.equals(query.trim().toLowerCase()),
        ))
        .go();
  }

  Future<void> clearSearchHistory() => delete(searchHistories).go();

  Stream<List<VodItem>> watchFavoriteVods() {
    final query = select(storedVods).join([
      innerJoin(vodFavorites, vodFavorites.vodId.equalsExp(storedVods.id)),
    ])..orderBy([OrderingTerm.desc(vodFavorites.createdAt)]);
    return query.watch().map(
      (rows) => rows
          .map((row) => vodItemFromStoredVod(stored: row.readTable(storedVods)))
          .toList(growable: false),
    );
  }

  Stream<bool> watchFavorite({required int vodId}) {
    final query = select(vodFavorites)
      ..where((row) => row.vodId.equals(vodId));
    return query.watchSingleOrNull().map((favorite) => favorite != null);
  }

  Future<void> toggleFavorite({required VodItem item}) async {
    await transaction(() async {
      await upsertVod(item: item);
      final favorite = await (select(vodFavorites)
            ..where((row) => row.vodId.equals(item.id)))
          .getSingleOrNull();
      if (favorite == null) {
        await into(vodFavorites).insert(
          VodFavoritesCompanion.insert(
            vodId: Value(item.id),
            createdAt: DateTime.now(),
          ),
        );
      } else {
        await (delete(vodFavorites)..where((row) => row.vodId.equals(item.id)))
            .go();
      }
    });
  }

  Stream<List<VodItem>> watchViewingHistory() {
    final query = select(storedVods).join([
      innerJoin(
        vodViewingHistories,
        vodViewingHistories.vodId.equalsExp(storedVods.id),
      ),
    ])..orderBy([OrderingTerm.desc(vodViewingHistories.watchedAt)]);
    return query.watch().map(
      (rows) => rows
          .map((row) => vodItemFromStoredVod(stored: row.readTable(storedVods)))
          .toList(growable: false),
    );
  }

  Future<void> recordViewing({
    required VodItem item,
    required PlaySource source,
    required PlayEpisode episode,
  }) async {
    await transaction(() async {
      await upsertVod(item: item);
      await into(vodViewingHistories).insertOnConflictUpdate(
        VodViewingHistoriesCompanion.insert(
          vodId: Value(item.id),
          sourceName: source.name,
          episodeName: episode.name,
          episodeUrl: episode.url,
          watchedAt: DateTime.now(),
        ),
      );
    });
  }

  Future<void> clearViewingHistory() => delete(vodViewingHistories).go();

  Future<void> upsertVod({required VodItem item}) {
    return into(storedVods).insertOnConflictUpdate(
      StoredVodsCompanion.insert(
        id: Value(item.id),
        typeId: item.typeId,
        parentTypeId: item.parentTypeId,
        name: item.name,
        typeName: item.typeName,
        picture: item.picture,
        remarks: item.remarks,
        year: item.year,
        area: item.area,
        language: item.language,
        score: item.score,
        doubanScore: item.doubanScore,
        actor: item.actor,
        director: item.director,
        category: item.category,
        summary: item.summary,
        duration: item.duration,
        playFrom: item.playFrom,
        playUrl: item.playUrl,
      ),
    );
  }

  VodItem vodItemFromStoredVod({required StoredVod stored}) {
    return VodItem(
      id: stored.id,
      typeId: stored.typeId,
      parentTypeId: stored.parentTypeId,
      name: stored.name,
      typeName: stored.typeName,
      picture: stored.picture,
      remarks: stored.remarks,
      year: stored.year,
      area: stored.area,
      language: stored.language,
      score: stored.score,
      doubanScore: stored.doubanScore,
      actor: stored.actor,
      director: stored.director,
      category: stored.category,
      summary: stored.summary,
      duration: stored.duration,
      playFrom: stored.playFrom,
      playUrl: stored.playUrl,
    );
  }
}
