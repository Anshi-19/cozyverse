import 'package:flutter/material.dart';

import '../../data/library_catalog.dart';
import '../../models/library_story.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/delete_story_dialog.dart';
import '../../widgets/library_story_card.dart';
import 'add_story_sheet.dart';
import 'story_actions_sheet.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  static const _tabs = [
    (emoji: '📚', label: 'Books'),
    (emoji: '🎬', label: 'Movies'),
    (emoji: '📺', label: 'Series'),
  ];

  late final LibraryCatalog _catalog = LibraryCatalog.create();

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

  void _openEditStorySheet(LibraryStory story) {
    if (!_catalog.isUserStory(story)) {
      return;
    }

    AddStorySheet.show(
      context,
      storyToEdit: story,
      onSave: (updatedStory) async {
        await _catalog.updateStory(updatedStory);
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  void _openStoryActionsSheet(LibraryStory story) {
    if (!_catalog.isUserStory(story)) {
      return;
    }

    StoryActionsSheet.show(
      context,
      story: story,
      onEdit: () => _openEditStorySheet(story),
      onDelete: () => _confirmDeleteStory(story),
    );
  }

  Future<void> _confirmDeleteStory(LibraryStory story) async {
    final confirmed = await DeleteStoryDialog.show(context);
    if (!confirmed || !mounted) {
      return;
    }

    await _catalog.deleteStory(story);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _openAddStorySheet,
          backgroundColor: AppColors.lavenderDark,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Story'),
        ),
        body: Stack(
          children: [
            const _LibraryBackground(),
            const DecorativeStars(),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _LibraryHeader(),
                  _LibraryTabBar(tabs: _tabs),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _LibraryStoryList(
                          stories: _catalog.books,
                          isUserStory: _catalog.isUserStory,
                          onStoryTap: _openEditStorySheet,
                          onStoryLongPress: _openStoryActionsSheet,
                        ),
                        _LibraryStoryList(
                          stories: _catalog.movies,
                          isUserStory: _catalog.isUserStory,
                          onStoryTap: _openEditStorySheet,
                          onStoryLongPress: _openStoryActionsSheet,
                        ),
                        _LibraryStoryList(
                          stories: _catalog.series,
                          isUserStory: _catalog.isUserStory,
                          onStoryTap: _openEditStorySheet,
                          onStoryLongPress: _openStoryActionsSheet,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryHeader extends StatelessWidget {
  const _LibraryHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.lavenderLight.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: AppColors.lavenderDark,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Library',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'A magical collection of stories',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LibraryTabBar extends StatelessWidget {
  const _LibraryTabBar({required this.tabs});

  final List<({String emoji, String label})> tabs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.creamSurface.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.lavenderLight.withValues(alpha: 0.45),
          ),
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColors.lavenderLight.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(14),
          ),
          labelColor: AppColors.lavenderDark,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          tabs: tabs
              .map(
                (tab) => Tab(
                  child: Text('${tab.emoji} ${tab.label}'),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _LibraryStoryList extends StatelessWidget {
  const _LibraryStoryList({
    required this.stories,
    required this.isUserStory,
    required this.onStoryTap,
    required this.onStoryLongPress,
  });

  final List<LibraryStory> stories;
  final bool Function(LibraryStory story) isUserStory;
  final ValueChanged<LibraryStory> onStoryTap;
  final ValueChanged<LibraryStory> onStoryLongPress;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.clamp(0.0, 640.0);

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 88 + bottomPadding),
              itemCount: stories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final story = stories[index];
                final isUserCreated = isUserStory(story);

                return LibraryStoryCard(
                  story: story,
                  onTap: isUserCreated ? () => onStoryTap(story) : null,
                  onLongPress:
                      isUserCreated ? () => onStoryLongPress(story) : null,
                );
              },
            ),
          ),
        );
      },
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
