import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class RecommendationRatingRow extends StatelessWidget {
  const RecommendationRatingRow({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '★★★★★',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFE8C468),
            letterSpacing: 0.5,
            height: 1,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
        ),
      ],
    );
  }
}
