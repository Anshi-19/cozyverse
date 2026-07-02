import 'package:flutter/material.dart';

import '../../models/story_tracker_item.dart';
import '../../theme/app_theme.dart';

class LibraryTabEmptyState extends StatelessWidget {
  const LibraryTabEmptyState({
    super.key,
    required this.tab,
  });

  final StoryJourneyTab tab;

  static const _illustrationPaths = {
    StoryJourneyTab.wishlist: 'assets/illustrations/journey_want_empty.png',
    StoryJourneyTab.completed:
        'assets/illustrations/journey_completed_empty.png',
  };

  String get _message {
    return switch (tab) {
      StoryJourneyTab.wishlist => 'Your next adventure is waiting.',
      StoryJourneyTab.completed =>
        'Every finished story becomes a memory.',
    };
  }

  IconData get _fallbackIcon {
    return switch (tab) {
      StoryJourneyTab.wishlist => Icons.explore_rounded,
      StoryJourneyTab.completed => Icons.emoji_events_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              _illustrationPaths[tab]!,
              width: 132,
              height: 132,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 132,
                  height: 132,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFF0E5),
                        Color(0xFFE8DFF5),
                        Color(0xFFEDE4F7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.lavenderLight.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Icon(
                    _fallbackIcon,
                    size: 52,
                    color: AppColors.lavenderDark.withValues(alpha: 0.55),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 22),
          Text(
            _message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }
}
