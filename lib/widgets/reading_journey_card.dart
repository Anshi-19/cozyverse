import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'cozy_card.dart';

class ReadingJourneyCard extends StatelessWidget {
  const ReadingJourneyCard({
    super.key,
    required this.totalBooks,
    required this.totalMovies,
    required this.totalSeries,
  });

  final int totalBooks;
  final int totalMovies;
  final int totalSeries;

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      child: Row(
        children: [
          Expanded(
            child: _JourneyStat(
              emoji: '📚',
              label: 'Books',
              count: totalBooks,
            ),
          ),
          Container(
            width: 1,
            height: 52,
            color: AppColors.lavenderLight.withValues(alpha: 0.5),
          ),
          Expanded(
            child: _JourneyStat(
              emoji: '🎬',
              label: 'Movies',
              count: totalMovies,
            ),
          ),
          Container(
            width: 1,
            height: 52,
            color: AppColors.lavenderLight.withValues(alpha: 0.5),
          ),
          Expanded(
            child: _JourneyStat(
              emoji: '📺',
              label: 'Series',
              count: totalSeries,
            ),
          ),
        ],
      ),
    );
  }
}

class _JourneyStat extends StatelessWidget {
  const _JourneyStat({
    required this.emoji,
    required this.label,
    required this.count,
  });

  final String emoji;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text(
          '$count',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
