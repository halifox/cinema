import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../cms/cms_models.dart';
import '../../../shared/application/shared_preferences_provider.dart';

const favoriteStoreKey = 'cinema.favorite.vods';

class FavoritesNotifier extends Notifier<List<VodItem>> {
  @override
  List<VodItem> build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final encoded = preferences.getString(favoriteStoreKey);
    if (encoded == null || encoded.isEmpty) return const [];
    try {
      final decoded = jsonDecode(encoded);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map>()
          .map((item) => VodItem.fromJson(Map<String, dynamic>.from(item)))
          .toList(growable: false);
    } on FormatException {
      return const [];
    }
  }

  bool contains({required int id}) => state.any((item) => item.id == id);

  Future<void> toggle({required VodItem item}) async {
    if (contains(id: item.id)) {
      state = state.where((favorite) => favorite.id != item.id).toList();
    } else {
      state = [item, ...state];
    }
    await persist();
  }

  Future<void> persist() {
    final encoded = jsonEncode(state.map((item) => item.toJson()).toList());
    return ref
        .read(sharedPreferencesProvider)
        .setString(favoriteStoreKey, encoded);
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<VodItem>>(
  FavoritesNotifier.new,
);
