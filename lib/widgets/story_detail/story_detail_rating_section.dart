import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../recommendations/recommendation_rating_row.dart';
import 'story_detail_section.dart';

class StoryDetailRatingSection extends StatelessWidget {
  const StoryDetailRatingSection({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return StoryDetailSection(
      title: 'Community Rating',
      subtitle: 'How readers feel about this story',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.creamSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.lavenderLight.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecommendationRatingRow(rating: rating),
                  const SizedBox(height: 8),
                  Text(
                    'Based on community reviews',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5EC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.lavenderLight.withValues(alpha: 0.45),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '—',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.lavenderDark,
                        ),
                  ),
                  Text(
                    'reviews',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
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
