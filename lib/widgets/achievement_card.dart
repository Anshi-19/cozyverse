import 'package:flutter/material.dart';

import '../models/achievement.dart';
import '../theme/app_theme.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    super.key,
    required this.achievement,
  });

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    final isUnlocked = achievement.isUnlocked;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      opacity: isUnlocked ? 1 : 0.45,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isUnlocked
                ? const [
                    Color(0xFFFFF3E8),
                    Color(0xFFF5EEFB),
                    Color(0xFFEDE4F7),
                  ]
                : [
                    AppColors.creamSurface,
                    AppColors.creamSurface,
                  ],
          ),
          border: Border.all(
            color: isUnlocked
                ? AppColors.lavenderLight.withValues(alpha: 0.65)
                : AppColors.lavenderLight.withValues(alpha: 0.3),
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: AppColors.lavender.withValues(alpha: 0.14),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  achievement.emoji,
                  style: TextStyle(
                    fontSize: 28,
                    color: isUnlocked ? null : AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Icon(
                  isUnlocked ? Icons.check_circle_rounded : Icons.lock_rounded,
                  size: 18,
                  color: isUnlocked
                      ? const Color(0xFF4A7A5A)
                      : AppColors.textSecondary.withValues(alpha: 0.6),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              achievement.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: isUnlocked
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              isUnlocked ? 'Unlocked' : 'Locked',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isUnlocked
                        ? const Color(0xFF4A7A5A)
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
