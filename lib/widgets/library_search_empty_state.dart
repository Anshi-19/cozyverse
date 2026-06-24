import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LibrarySearchEmptyState extends StatelessWidget {
  const LibrarySearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lavenderLight.withValues(alpha: 0.35),
                border: Border.all(
                  color: AppColors.lavenderLight.withValues(alpha: 0.55),
                ),
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 40,
                color: AppColors.lavenderDark.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No stories found',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Try a different title.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
