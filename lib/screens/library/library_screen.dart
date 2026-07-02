import 'package:flutter/material.dart';

import '../../data/story_tracker_storage.dart';
import '../../models/library_type_filter.dart';
import '../../models/story_tracker_item.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/library/library_completed_item.dart';
import '../../widgets/library/library_journey_header.dart';
import '../../widgets/library/library_journey_tabs.dart';
import '../../widgets/library/library_tab_empty_state.dart';
import '../../widgets/library/library_type_filter_chips.dart';
import '../../widgets/library/library_want_item.dart';
import '../../widgets/library_search_field.dart';
import '../../data/library_catalog.dart';
import 'add_story_sheet.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late final LibraryCatalog _catalog = LibraryCatalog.create();
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  final _searchController = TextEditingController();
  StoryJourneyTab _selectedTab = StoryJourneyTab.wishlist;
  LibraryTypeFilter _selectedTypeFilter = LibraryTypeFilter.all;
  String _searchQuery = '';

  static const _horizontalPadding = 24.0;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
    StoryTrackerStorage.instance.addListener(_onTrackerChanged);
  }

  @override
  void dispose() {
    StoryTrackerStorage.instance.removeListener(_onTrackerChanged);
    _fadeController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTrackerChanged() {
    setState(() {});
  }

  Map<StoryJourneyTab, int> get _tabCounts {
    final storage = StoryTrackerStorage.instance;

    int countFor(StoryJourneyTab tab) {
      return storage
          .itemsFor(tab)
          .where((item) => _selectedTypeFilter.matches(item.story))
          .length;
    }

    return {
      StoryJourneyTab.wishlist: countFor(StoryJourneyTab.wishlist),
      StoryJourneyTab.completed: countFor(StoryJourneyTab.completed),
    };
  }

  List<StoryTrackerItem> get _visibleItems {
    final items = StoryTrackerStorage.instance.itemsFor(_selectedTab);
    final query = _searchQuery.trim().toLowerCase();

    return items.where((item) {
      if (!_selectedTypeFilter.matches(item.story)) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }
      return item.story.title.toLowerCase().contains(query);
    }).toList();
  }

  void _openAddStorySheet() {
    AddStorySheet.show(
      context,
      onSave: (story) async {
        await _catalog.addStory(story);
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final visibleItems = _visibleItems;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddStorySheet,
        backgroundColor: AppColors.lavenderDark,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add'),
      ),
      body: Stack(
        children: [
          const _LibraryBackground(),
          const DecorativeStars(),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      _horizontalPadding,
                      16,
                      _horizontalPadding,
                      16,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const LibraryJourneyHeader(),
                        const SizedBox(height: 20),
                        LibrarySearchField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() => _searchQuery = value);
                          },
                        ),
                        const SizedBox(height: 14),
                        LibraryTypeFilterChips(
                          selectedFilter: _selectedTypeFilter,
                          onSelected: (filter) {
                            setState(() => _selectedTypeFilter = filter);
                          },
                        ),
                        const SizedBox(height: 18),
                        LibraryJourneyTabs(
                          selectedTab: _selectedTab,
                          counts: _tabCounts,
                          onSelected: (tab) {
                            setState(() => _selectedTab = tab);
                          },
                        ),
                        const SizedBox(height: 24),
                      ]),
                    ),
                  ),
                  if (visibleItems.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: LibraryTabEmptyState(tab: _selectedTab),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        _horizontalPadding,
                        0,
                        _horizontalPadding,
                        88 + bottomPadding,
                      ),
                      sliver: SliverList.separated(
                        itemCount: visibleItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final item = visibleItems[index];

                          return switch (_selectedTab) {
                            StoryJourneyTab.wishlist => LibraryWantItem(
                                item: item,
                                onStart: () => StoryTrackerStorage.instance
                                    .startStory(item.story.id),
                              ),
                            StoryJourneyTab.completed => LibraryCompletedItem(
                                item: item,
                                onRatingChanged: (rating) {
                                  StoryTrackerStorage.instance.updateUserRating(
                                    item.story.id,
                                    rating,
                                  );
                                },
                              ),
                          };
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryBackground extends StatelessWidget {
  const _LibraryBackground();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cream,
            Color(0xFFFFF5EC),
            Color(0xFFF8F2FC),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lavenderLight.withValues(alpha: 0.2),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.15,
            left: -60,
            child: Container(
              width: size.width * 0.45,
              height: size.width * 0.45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFE8D6).withValues(alpha: 0.25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
