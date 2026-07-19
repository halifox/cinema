import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/application/shared_preferences_provider.dart';

const searchHistoryStoreKey = 'cinema.search.history';

class SearchHistoryNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return ref
            .watch(sharedPreferencesProvider)
            .getStringList(searchHistoryStoreKey) ??
        const [];
  }

  Future<void> record({required String query}) async {
    final value = query.trim();
    if (value.isEmpty) return;
    state = [
      value,
      ...state.where((item) => item.toLowerCase() != value.toLowerCase()),
    ].take(12).toList(growable: false);
    await persist();
  }

  Future<void> remove({required String query}) async {
    state = state.where((item) => item != query).toList(growable: false);
    await persist();
  }

  Future<void> clear() async {
    state = const [];
    await persist();
  }

  Future<void> persist() {
    return ref
        .read(sharedPreferencesProvider)
        .setStringList(searchHistoryStoreKey, state);
  }
}

final searchHistoryProvider =
    NotifierProvider<SearchHistoryNotifier, List<String>>(
      SearchHistoryNotifier.new,
    );
