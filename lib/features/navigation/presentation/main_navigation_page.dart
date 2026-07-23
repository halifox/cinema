import 'dart:async';

import 'package:cinema/features/home/presentation/home_page.dart';
import 'package:cinema/features/library/application/library_providers.dart';
import 'package:cinema/features/library/presentation/vod_library_page.dart';
import 'package:cinema/features/search/presentation/search_category_page.dart';
import 'package:cinema/features/search/presentation/search_history_page.dart';
import 'package:cinema/features/search/presentation/search_results_page.dart';
import 'package:cinema/shared/presentation/hooks/glass_large_title_hook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class MainNavigationPage extends HookConsumerWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    final lastContentIndex = useState(0);
    final searchController = useTextEditingController();
    final searchTitleController = useGlassLargeTitleController();
    return Stack(
      children: [
        switch (selectedIndex.value) {
          0 => const HomePage(),
          1 => const VodLibraryPage(),
          4 => SearchCategoryPage(
            titleController: searchTitleController,
            onDismiss: () {
              FocusManager.instance.primaryFocus?.unfocus();
              selectedIndex.value = lastContentIndex.value;
            },
          ),
          5 => SearchHistoryPage(
            titleController: searchTitleController,
            onDismiss: () {
              FocusManager.instance.primaryFocus?.unfocus();
              selectedIndex.value = lastContentIndex.value;
            },
          ),
          _ => const SizedBox.shrink(),
        },
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: GlassTabBar.searchable(
              selectedIndex: lastContentIndex.value,
              isSearchActive:
                  selectedIndex.value == 4 || selectedIndex.value == 5,
              onTabSelected: (value) {
                selectedIndex.value = value;
                lastContentIndex.value = value;
              },
              searchConfig: GlassSearchBarConfig(
                controller: searchController,
                hintText: '搜索电影、剧集、综艺',
                autoFocusOnExpand: false,
                showsCancelButton: true,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  final query = value.trim();
                  if (query.isEmpty) return;
                  unawaited(
                    ref
                        .read(libraryCommandsProvider)
                        .recordSearch(query: query),
                  );
                  searchController.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context).push(
                    CupertinoPageRoute<void>(
                      builder: (routeContext) =>
                          SearchResultsPage(query: query),
                    ),
                  );
                },
                onSearchToggle: (active) {
                  if (active) {
                    if (selectedIndex.value < 2) {
                      lastContentIndex.value = selectedIndex.value;
                    }
                    selectedIndex.value = 4;
                  } else {
                    selectedIndex.value = lastContentIndex.value;
                  }
                },
                onSearchFocusChanged: (focused) {
                  if (selectedIndex.value == 4 || selectedIndex.value == 5) {
                    selectedIndex.value = focused ? 5 : 4;
                  }
                },
              ),
              barHeight: 62,
              searchBarHeight: 52,
              verticalPadding: 12,
              horizontalPadding: 18,
              indicatorColor: CupertinoTheme.of(
                context,
              ).primaryColor.withValues(alpha: .18),
              interactionGlowColor: CupertinoTheme.of(context).primaryColor,
              selectedIconColor: CupertinoColors.label.resolveFrom(context),
              unselectedIconColor: CupertinoColors.label.resolveFrom(context),
              tabs: const [
                GlassTab(
                  icon: Icon(CupertinoIcons.house),
                  activeIcon: Icon(CupertinoIcons.house_fill),
                  label: '首页',
                  glowColor: Color(0xFFFF5A5F),
                ),
                GlassTab(
                  icon: Icon(CupertinoIcons.rectangle_stack),
                  activeIcon: Icon(CupertinoIcons.rectangle_stack_fill),
                  label: '片单',
                  glowColor: Color(0xFF5C9AF6),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
