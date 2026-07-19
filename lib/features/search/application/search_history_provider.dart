import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../library/data/library_database.dart';

final searchHistoryProvider = StreamProvider<List<String>>((ref) {
  return ref.watch(libraryDatabaseProvider).watchSearchHistory();
});
