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
      child: Column(
        children: [
          _DetailRow(label: 'Category', value: category),
          const Divider(height: 24, color: Color(0xFFE8DFF5)),
          _DetailRow(label: 'Recommended Mood', value: recommendedMood),
          const Divider(height: 24, color: Color(0xFFE8DFF5)),
          _DetailRow(label: 'Estimated Time', value: estimatedTime),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
