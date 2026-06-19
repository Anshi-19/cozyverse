import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'cozy_card.dart';

class StoryMoodCard extends StatelessWidget {
  const StoryMoodCard({
    super.key,
    required this.moodTitle,
    required this.description,
  });

  final String moodTitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFF3E8),
          Color(0xFFF5EEFB),
          Color(0xFFEDE4F7),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.55),
              border: Border.all(
                color: AppColors.lavenderLight.withValues(alpha: 0.7),
              ),
            ),
            child: const Icon(
              Icons.local_cafe_rounded,
              color: AppColors.lavenderDark,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Story Mood",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  moodTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.45,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
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
