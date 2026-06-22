import 'package:flutter/material.dart';

import '../data/mood_data.dart';
import '../data/recommendation_data.dart';
import '../models/recommendation.dart';
import '../theme/app_theme.dart';
import 'category_badge.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.moodId,
    this.width = 176,
  });

  final Recommendation recommendation;
  final String moodId;
  final double width;

  @override
  Widget build(BuildContext context) {
    final mood = MoodData.findById(moodId);
    final gradientColors =
        RecommendationData.gradientForCategory(recommendation.category);

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.creamSurface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderLight.withValues(alpha: 0.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 96,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                    child: Icon(
                      recommendation.icon,
                      size: 30,
                      color: AppColors.lavenderDark,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CategoryBadge(label: recommendation.category),
              ),
              if (mood != null)
                Positioned(
                  top: 10,
                  right: 10,
                  child: _MoodBadge(label: mood.displayLabel),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recommendation.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  recommendation.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.35,
                        color: AppColors.textSecondary,
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

class _MoodBadge extends StatelessWidget {
  const _MoodBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lavenderLight.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.lavenderDark.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.lavenderDark,
        ),
      ),
    );
  }
}
