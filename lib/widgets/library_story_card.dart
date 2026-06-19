import 'package:flutter/material.dart';

import '../models/library_story.dart';
import '../theme/app_theme.dart';
import 'status_badge.dart';

class LibraryStoryCard extends StatelessWidget {
  const LibraryStoryCard({
    super.key,
    required this.story,
  });

  final LibraryStory story;

  @override
  Widget build(BuildContext context) {
    final progressPercent = (story.progress * 100).round();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.creamSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _CoverPlaceholder(
            icon: story.icon,
            gradientColors: story.gradientColors,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.25,
                      ),
                ),
                const SizedBox(height: 8),
                StatusBadge(status: story.status),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _RatingDisplay(rating: story.rating),
                    const Spacer(),
                    Text(
                      '$progressPercent%',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.lavenderDark,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: story.progress,
                    minHeight: 6,
                    backgroundColor:
                        AppColors.lavenderLight.withValues(alpha: 0.35),
                    color: AppColors.lavenderDark,
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

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({
    required this.icon,
    required this.gradientColors,
  });

  final IconData icon;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: 28,
          color: AppColors.lavenderDark.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}

class _RatingDisplay extends StatelessWidget {
  const _RatingDisplay({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    if (rating <= 0) {
      return Text(
        'Not rated',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          size: 16,
          color: Color(0xFFE8C468),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
      ],
    );
  }
}
