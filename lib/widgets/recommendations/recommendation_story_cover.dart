import 'package:flutter/material.dart';

import '../../data/recommendation_data.dart';
import '../../data/recommendation_presentation.dart';
import '../../models/recommendation.dart';
import '../../theme/app_theme.dart';

class RecommendationStoryCover extends StatelessWidget {
  const RecommendationStoryCover({
    super.key,
    required this.recommendation,
    required this.borderRadius,
  });

  final Recommendation recommendation;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final assetPath = RecommendationPresentation.coverAssetPath(recommendation);
    final gradientColors =
        RecommendationData.gradientForCategory(recommendation.category);

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            assetPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.38),
                    ),
                    child: Icon(
                      recommendation.icon,
                      size: 40,
                      color: AppColors.lavenderDark,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.textPrimary.withValues(alpha: 0.08),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
