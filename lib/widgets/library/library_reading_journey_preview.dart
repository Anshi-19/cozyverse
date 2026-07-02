import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../cozy_card.dart';

class LibraryReadingJourneyPreview extends StatelessWidget {
  const LibraryReadingJourneyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lavenderLight.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.route_rounded,
                  size: 18,
                  color: AppColors.lavenderDark,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Reading Journey',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(
                child: _JourneyMetric(
                  label: 'Stories Completed',
                  value: '14',
                ),
              ),
              Expanded(
                child: _JourneyMetric(
                  label: 'Current Streak',
                  value: '5 days',
                ),
              ),
              Expanded(
                child: _JourneyMetric(
                  label: 'Favorite Mood',
                  value: '☕ Cozy',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _JourneyMetric extends StatelessWidget {
  const _JourneyMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
        ),
      ],
    );
  }
}
