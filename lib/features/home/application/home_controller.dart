import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../cms/cms_models.dart';
import '../../../cms/cms_providers.dart';

typedef HomeCatalogData = ({
  List<CmsCategory> primary,
  List<CmsCategory> secondary,
  int? selectedPrimaryId,
  int? selectedSecondaryId,
  int? activeTypeId,
});

class HomeFilterState {
  const HomeFilterState({
    this.selectedPrimaryId,
    this.selectedSecondaryId,
  });

  final int? selectedPrimaryId;
  final int? selectedSecondaryId;
}

class HomeFilterController extends Notifier<HomeFilterState> {
  @override
  HomeFilterState build() => const HomeFilterState();

  void selectPrimary({required int id}) {
    if (state.selectedPrimaryId == id &&
        state.selectedSecondaryId == null) {
      return;
    }
    state = HomeFilterState(selectedPrimaryId: id);
  }

  void selectSecondary({required int id}) {
    if (state.selectedSecondaryId == id) return;
    state = HomeFilterState(
      selectedPrimaryId: state.selectedPrimaryId,
      selectedSecondaryId: id,
    );
  }
}

final homeFilterProvider =
    NotifierProvider<HomeFilterController, HomeFilterState>(
      HomeFilterController.new,
    );

final homeCatalogProvider = Provider<AsyncValue<HomeCatalogData>>((ref) {
  final filter = ref.watch(homeFilterProvider);
  return ref.watch(categoriesProvider).whenData((page) {
    final primary = page.categories
        .where((category) => category.parentId == 0)
        .toList(growable: false);
    if (primary.isEmpty) {
      return (
        primary: primary,
        secondary: const <CmsCategory>[],
        selectedPrimaryId: null,
        selectedSecondaryId: null,
        activeTypeId: null,
      );
    }

    final selectedPrimaryId = primary.any(
      (category) => category.id == filter.selectedPrimaryId,
    )
        ? filter.selectedPrimaryId!
        : primary.first.id;
    final secondary = page.categories
        .where((category) => category.parentId == selectedPrimaryId)
        .toList(growable: false);
    final int? selectedSecondaryId;
    if (secondary.any(
      (category) => category.id == filter.selectedSecondaryId,
    )) {
      selectedSecondaryId = filter.selectedSecondaryId;
    } else {
      selectedSecondaryId = secondary.isEmpty ? null : secondary.first.id;
    }

    return (
      primary: primary,
      secondary: secondary,
      selectedPrimaryId: selectedPrimaryId,
      selectedSecondaryId: selectedSecondaryId,
      activeTypeId: selectedSecondaryId ?? selectedPrimaryId,
    );
  });
});
