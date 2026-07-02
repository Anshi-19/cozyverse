import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'story_detail_section.dart';

class StoryDetailQuoteCard extends StatelessWidget {
  const StoryDetailQuoteCard({super.key});

  static const _placeholderQuote =
      'Stories are memory containers — a favorite line from this tale will appear here soon.';

  @override
  Widget build(BuildContext context) {
    return StoryDetailSection(
      title: 'Favorite Quote',
      subtitle: 'A line worth remembering',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
        decoration: BoxDecoration(
          color: AppColors.creamSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.lavenderLight.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lavender.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '“',
              style: TextStyle(
                fontSize: 36,
                height: 0.9,
                fontWeight: FontWeight.w700,
                color: AppColors.lavender.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _placeholderQuote,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.55,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
