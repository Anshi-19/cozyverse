import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class JournalHeader extends StatelessWidget {
  const JournalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lavenderLight.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: AppColors.lavenderDark,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Story Journal',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Capture how every story made you feel.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
