import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class RecommendationGenreChip extends StatelessWidget {
  const RecommendationGenreChip({
    super.key,
    required this.label,
    required this.backgroundColor,
  });

  final String label;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.45),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.lavenderDark,
              fontSize: 10,
            ),
      ),
    );
  }
}
