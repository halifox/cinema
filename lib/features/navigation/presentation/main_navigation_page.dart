import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../favorites/presentation/favorite_page.dart';
import '../../home/presentation/home_page.dart';
import '../../library/application/library_providers.dart';
import '../../search/presentation/search_page.dart';
import '../../search/presentation/search_results_page.dart';

enum MainContentTab {
  home(
    label: '首页',
    icon: CupertinoIcons.house,
    activeIcon: CupertinoIcons.house_fill,
  ),
  favorite(
    label: '收藏',
    icon: CupertinoIcons.heart,
    activeIcon: CupertinoIcons.heart_fill,
    glowColor: Color(0xFFFF375F),
  );

  const MainContentTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.glowColor,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Color? glowColor;

  Widget buildPage() => switch (this) {
    MainContentTab.home => const HomePage(),
    MainContentTab.favorite => const FavoritePage(),
  };
}

typedef MainNavigationState = ({
  MainContentTab selectedTab,
  bool isSearching,
});

class MainNavigationPage extends HookConsumerWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = useState<MainNavigationState>(
      (selectedTab: MainContentTab.home, isSearching: false),
    );
    final searchController = useTextEditingController();

    void showTab({required MainContentTab tab}) {
      navigation.value = (selectedTab: tab, isSearching: false);
    }

    void setSearchActive({required bool active}) {
      navigation.value = (
        selectedTab: navigation.value.selectedTab,
        isSearching: active,
      );
    }

    return Stack(
      children: [
        navigation.value.isSearching
            ? SearchPage(
                onDismiss: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setSearchActive(active: false);
                },
              )
            : navigation.value.selectedTab.buildPage(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: GlassTabBar.searchable(
              selectedIndex: navigation.value.selectedTab.index,
              isSearchActive: navigation.value.isSearching,
              onTabSelected: (index) {
                showTab(tab: MainContentTab.values[index]);
              },
              searchConfig: GlassSearchBarConfig(
                controller: searchController,
                hintText: '搜索电影、剧集、综艺',
                autoFocusOnExpand: true,
                showsCancelButton: false,
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
                  setSearchActive(active: active);
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
              tabs: [
                for (final tab in MainContentTab.values)
                  GlassTab(
                    icon: Icon(tab.icon),
                    activeIcon: Icon(tab.activeIcon),
                    label: tab.label,
                    glowColor:
                        tab.glowColor ??
                        CupertinoTheme.of(context).primaryColor,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
