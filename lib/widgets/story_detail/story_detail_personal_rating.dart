import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../ratings/cozy_star_rating.dart';
import 'story_detail_section.dart';

class StoryDetailPersonalRating extends StatelessWidget {
  const StoryDetailPersonalRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return StoryDetailSection(
      title: 'Your Rating',
      subtitle: 'How did this story feel to you?',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.creamSurface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.lavenderDark.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lavenderDark.withValues(alpha: 0.1),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CozyStarRating(
              rating: rating,
              starSize: 40,
              spacing: 10,
              onRatingChanged: onRatingChanged,
            ),
            const SizedBox(height: 12),
            Text(
              rating == 0
                  ? 'Tap the stars to share your rating'
                  : 'You rated this story $rating / 5',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
