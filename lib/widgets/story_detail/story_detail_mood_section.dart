import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'story_detail_section.dart';

class StoryDetailMoodSection extends StatelessWidget {
  const StoryDetailMoodSection({
    super.key,
    required this.moodLabel,
    required this.blurb,
    required this.matchText,
  });

  final String moodLabel;
  final String blurb;
  final String matchText;

  @override
  Widget build(BuildContext context) {
    return StoryDetailSection(
      title: 'Why This Matches Your Mood',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3E8),
              Color(0xFFF5EEFB),
              Color(0xFFEDE4F7),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.lavenderLight.withValues(alpha: 0.55),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lavenderLight.withValues(alpha: 0.14),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.creamSurface.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.lavenderLight.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    moodLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.lavenderDark,
                        ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.auto_awesome_rounded,
                  size: 18,
                  color: AppColors.lavenderDark.withValues(alpha: 0.55),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              blurb,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              matchText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
