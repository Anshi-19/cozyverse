import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../ratings/cozy_star_rating.dart';

class StoryDetailCommunityRating extends StatelessWidget {
  const StoryDetailCommunityRating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF8F0),
            Color(0xFFF5EEFB),
            Color(0xFFFFF0E5),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Community Rating',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.lavenderDark,
                  letterSpacing: 0.3,
                ),
          ),
          const SizedBox(height: 14),
          CozyStarDisplay(rating: rating, starSize: 26),
          const SizedBox(height: 10),
          Text(
            '120k Community Ratings',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
