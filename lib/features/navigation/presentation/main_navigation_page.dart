import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../../favorites/presentation/favorite_page.dart';
import '../../home/presentation/home_page.dart';
import '../../search/application/search_history_provider.dart';
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

class MainNavigationPage extends HookConsumerWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(MainContentTab.home);
    final lastContentTab = useState(MainContentTab.home);
    final isSearching = useState(false);
    final searchController = useTextEditingController();

    return Stack(
      children: [
        isSearching.value
            ? const SearchPage()
            : selectedTab.value.buildPage(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            top: false,
            child: GlassTabBar.searchable(
              selectedIndex: lastContentTab.value.index,
              isSearchActive: isSearching.value,
              onTabSelected: (index) {
                final tab = MainContentTab.values[index];
                selectedTab.value = tab;
                lastContentTab.value = tab;
                isSearching.value = false;
              },
              searchConfig: GlassSearchBarConfig(
                controller: searchController,
                hintText: '搜索电影、剧集、综艺',
                autoFocusOnExpand: false,
                showsCancelButton: false,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  final query = value.trim();
                  if (query.isEmpty) return;
                  ref.read(searchHistoryProvider.notifier).record(query: query);
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
                    lastContentTab.value = selectedTab.value;
                    isSearching.value = true;
                  } else {
                    selectedTab.value = lastContentTab.value;
                    isSearching.value = false;
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
