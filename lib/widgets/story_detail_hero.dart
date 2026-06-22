import 'package:flutter/material.dart';

import '../data/recommendation_data.dart';
import '../models/recommendation.dart';
import '../theme/app_theme.dart';
import 'category_badge.dart';

class StoryDetailHero extends StatelessWidget {
  const StoryDetailHero({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final gradientColors =
        RecommendationData.gradientForCategory(recommendation.category);
    final height = MediaQuery.sizeOf(context).height * 0.34;

    return SizedBox(
      height: height.clamp(240.0, 320.0),
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  gradientColors.first,
                  gradientColors.last,
                  AppColors.cream,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 24,
            right: 28,
            child: Icon(
              Icons.auto_awesome,
              size: 18,
              color: AppColors.lavenderDark.withValues(alpha: 0.35),
            ),
          ),
          Positioned(
            top: 48,
            left: 32,
            child: Icon(
              Icons.star_rounded,
              size: 14,
              color: AppColors.lavenderDark.withValues(alpha: 0.3),
            ),
          ),
          Positioned(
            bottom: 28,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.creamSurface.withValues(alpha: 0.75),
                    border: Border.all(
                      color: AppColors.lavenderLight.withValues(alpha: 0.7),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lavenderDark.withValues(alpha: 0.18),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    recommendation.icon,
                    size: 52,
                    color: AppColors.lavenderDark,
                  ),
                ),
                const SizedBox(height: 16),
                CategoryBadge(label: recommendation.category),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
