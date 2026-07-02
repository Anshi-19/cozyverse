import 'package:flutter/material.dart';

import '../data/library_presentation.dart';
import '../theme/app_theme.dart';
import 'category_badge.dart';
import 'cozy_card.dart';

class ProfileStoryPersonalityCard extends StatelessWidget {
  const ProfileStoryPersonalityCard({super.key});

  static const _summary =
      '✨ You love comforting, magical and hopeful stories.';

  static const _topGenres = ['Fantasy', 'Adventure', 'Cozy', 'Mystery'];

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFF3E8),
          Color(0xFFF5EEFB),
          Color(0xFFEDE4F7),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 18,
                color: AppColors.lavenderDark.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _summary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Top Genres',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _topGenres.map((genre) {
              return CategoryBadge(
                label: genre,
                backgroundColor: _chipColorFor(genre),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static Color _chipColorFor(String genre) {
    if (genre == 'Cozy') {
      return const Color(0xFFFFF0E5);
    }
    return LibraryPresentation.chipColorFor(genre);
  }
}
