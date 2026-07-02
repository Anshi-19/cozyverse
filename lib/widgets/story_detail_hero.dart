import 'package:flutter/material.dart';

import '../models/recommendation.dart';
import '../theme/app_theme.dart';
import 'category_badge.dart';
import 'recommendations/recommendation_story_cover.dart';

class StoryDetailHero extends StatelessWidget {
  const StoryDetailHero({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.44;

    return SizedBox(
      height: height.clamp(280.0, 380.0),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          RecommendationStoryCover(
            recommendation: recommendation,
            borderRadius: BorderRadius.zero,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.textPrimary.withValues(alpha: 0.08),
                  Colors.transparent,
                  AppColors.cream.withValues(alpha: 0.05),
                  AppColors.cream.withValues(alpha: 0.92),
                ],
                stops: const [0.0, 0.35, 0.72, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 56,
            right: 24,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 20,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
          Positioned(
            top: 88,
            left: 28,
            child: Icon(
              Icons.star_rounded,
              size: 14,
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 36,
            child: CategoryBadge(
              label: recommendation.category,
              backgroundColor: AppColors.creamSurface.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}
