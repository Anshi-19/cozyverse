import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'cozy_card.dart';
import 'ratings/cozy_star_rating.dart';

class ProfileStoryMemoriesCard extends StatelessWidget {
  const ProfileStoryMemoriesCard({
    super.key,
    this.title = 'Harry Potter',
    this.completedLabel = 'Completed June 24',
    this.rating = 5,
    this.reflection = 'It felt like coming home.',
  });

  final String title;
  final String completedLabel;
  final int rating;
  final String reflection;

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF5EEFB),
          Color(0xFFFFF3E8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE8DFF5),
                      Color(0xFFD4C5E8),
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.lavenderLight.withValues(alpha: 0.5),
                  ),
                ),
                child: Icon(
                  Icons.auto_stories_rounded,
                  size: 22,
                  color: AppColors.lavenderDark.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      completedLabel,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _StarRow(rating: rating),
          const SizedBox(height: 12),
          Text(
            '"$reflection"',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.45,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final isFilled = index < rating;
        return Padding(
          padding: EdgeInsets.only(right: index < 4 ? 2 : 0),
          child: Icon(
            isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
            size: 18,
            color: isFilled
                ? CozyStarRating.activeColor
                : CozyStarRating.inactiveColor,
          ),
        );
      }),
    );
  }
}
