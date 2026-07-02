import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'cozy_card.dart';

class StoryDetailsCard extends StatelessWidget {
  const StoryDetailsCard({
    super.key,
    required this.category,
    required this.recommendedMood,
    required this.estimatedTime,
  });

  final String category;
  final String recommendedMood;
  final String estimatedTime;

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          _DetailRow(
            icon: Icons.category_rounded,
            label: 'Category',
            value: category,
          ),
          const _DetailDivider(),
          _DetailRow(
            icon: Icons.auto_awesome_outlined,
            label: 'Recommended Mood',
            value: recommendedMood,
          ),
          const _DetailDivider(),
          _DetailRow(
            icon: Icons.schedule_rounded,
            label: 'Estimated Time',
            value: estimatedTime,
          ),
        ],
      ),
    );
  }
}

class _DetailDivider extends StatelessWidget {
  const _DetailDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.lavenderLight.withValues(alpha: 0.35),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.lavenderLight.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.lavenderDark,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
