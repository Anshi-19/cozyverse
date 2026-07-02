import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../favorite_action_button.dart';

class StoryDetailActionBar extends StatelessWidget {
  const StoryDetailActionBar({
    super.key,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onAddToLibrary,
    required this.onStartStory,
  });

  final bool isFavorite;
  final VoidCallback? onFavoritePressed;
  final VoidCallback onAddToLibrary;
  final VoidCallback onStartStory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: FavoriteActionButton(
                isFavorite: isFavorite,
                onPressed: onFavoritePressed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SecondaryActionButton(
                label: 'Add to Library',
                emoji: '📚',
                onPressed: onAddToLibrary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.lavenderDark,
                  Color(0xFF9A88B8),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lavenderDark.withValues(alpha: 0.28),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onStartStory,
                borderRadius: BorderRadius.circular(18),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.auto_stories_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Start This Story',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({
    required this.label,
    required this.emoji,
    required this.onPressed,
  });

  final String label;
  final String emoji;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        backgroundColor: AppColors.creamSurface,
        side: BorderSide(
          color: AppColors.lavenderLight.withValues(alpha: 0.7),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        '$emoji $label',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
