import 'package:flutter/material.dart';

import '../../data/mood_data.dart';
import '../../data/recommendation_presentation.dart';
import '../../models/recommendation.dart';
import '../../theme/app_theme.dart';
import '../recommendations/recommendation_rating_row.dart';
import '../recommendations/recommendation_story_cover.dart';

class JournalStoryCard extends StatelessWidget {
  const JournalStoryCard({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final mood = MoodData.findById(recommendation.moodId);
    final moodLabel = mood?.displayLabel ?? recommendation.moodId;
    final rating = RecommendationPresentation.ratingFor(recommendation);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.creamSurface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.1),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 88,
              height: 112,
              child: RecommendationStoryCover(
                recommendation: recommendation,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.15,
                      ),
                ),
                const SizedBox(height: 10),
                _InfoChip(label: recommendation.category),
                const SizedBox(height: 6),
                _InfoChip(label: moodLabel, icon: Icons.auto_awesome_outlined),
                const SizedBox(height: 10),
                RecommendationRatingRow(rating: rating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    this.icon,
  });

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lavenderLight.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: AppColors.lavenderDark),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.lavenderDark,
                ),
          ),
        ],
      ),
    );
  }
}
