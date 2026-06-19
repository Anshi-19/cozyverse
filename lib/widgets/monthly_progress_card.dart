import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'cozy_card.dart';

class MonthlyProgressCard extends StatelessWidget {
  const MonthlyProgressCard({
    super.key,
    required this.completedCount,
    required this.progress,
  });

  final int completedCount;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      child: Row(
        children: [
          SizedBox(
            width: 88,
            height: 88,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 88,
                  height: 88,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor:
                        AppColors.lavenderLight.withValues(alpha: 0.35),
                    color: AppColors.lavenderDark,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lavenderDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Progress',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$completedCount stories completed this month',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.45,
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
