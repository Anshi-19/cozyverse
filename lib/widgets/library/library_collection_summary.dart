import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class LibraryCollectionSummary extends StatelessWidget {
  const LibraryCollectionSummary({
    super.key,
    required this.bookCount,
    required this.movieCount,
    required this.seriesCount,
  });

  final int bookCount;
  final int movieCount;
  final int seriesCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.creamSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(emoji: '📚', label: 'Books', count: bookCount),
          ),
          _SummaryDivider(),
          Expanded(
            child: _SummaryItem(emoji: '🎬', label: 'Movies', count: movieCount),
          ),
          _SummaryDivider(),
          Expanded(
            child: _SummaryItem(emoji: '📺', label: 'Series', count: seriesCount),
          ),
        ],
      ),
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: AppColors.lavenderLight.withValues(alpha: 0.45),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
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
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
