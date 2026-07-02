import 'package:flutter/material.dart';

import '../../data/library_presentation.dart';
import '../../models/library_story.dart';
import '../../theme/app_theme.dart';
import 'library_story_cover.dart';

class LibraryRecentlyAdded extends StatelessWidget {
  const LibraryRecentlyAdded({
    super.key,
    required this.stories,
  });

  final List<LibraryStory> stories;

  @override
  Widget build(BuildContext context) {
    if (stories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Added',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 168,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return _RecentStoryTile(story: stories[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _RecentStoryTile extends StatelessWidget {
  const _RecentStoryTile({required this.story});

  final LibraryStory story;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: LibraryStoryCover(
                story: story,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            story.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            LibraryPresentation.categoryLabel(story),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
