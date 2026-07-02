import 'package:flutter/material.dart';

import '../../data/library_presentation.dart';
import '../../models/story_tracker_item.dart';
import '../../theme/app_theme.dart';
import '../ratings/cozy_star_rating.dart';
import 'library_story_cover.dart';

class LibraryCompletedItem extends StatelessWidget {
  const LibraryCompletedItem({
    super.key,
    required this.item,
    required this.onRatingChanged,
  });

  final StoryTrackerItem item;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    final story = item.story;
    final completedDate = item.completedDate ?? DateTime.now();
    final userRating = item.userRating;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF8F0),
            Color(0xFFE8F5EC),
            Color(0xFFF5EEFB),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD8EDDF).withValues(alpha: 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A7A5A).withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 72,
                  height: 96,
                  child: LibraryStoryCover(
                    story: story,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A7A5A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.15,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your Rating',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                CozyStarRating(
                  rating: userRating,
                  starSize: 28,
                  spacing: 4,
                  onRatingChanged: onRatingChanged,
                ),
                const SizedBox(height: 10),
                Text(
                  LibraryPresentation.formattedCompletedDate(completedDate),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF4A7A5A),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
