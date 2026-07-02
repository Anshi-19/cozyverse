import 'package:flutter/material.dart';

import '../models/mood.dart';
import '../theme/app_theme.dart';
import 'cozy_card.dart';

class ProfileCurrentMoodCard extends StatelessWidget {
  const ProfileCurrentMoodCard({
    super.key,
    required this.mood,
  });

  final Mood mood;

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFFFF3E8).withValues(alpha: 0.9),
          const Color(0xFFF5EEFB).withValues(alpha: 0.85),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${mood.emoji} ${mood.name}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            "Today's Story Mood",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            mood.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
