import 'package:flutter/material.dart';

import '../../data/library_presentation.dart';
import '../../models/library_story.dart';
import '../../theme/app_theme.dart';
import 'library_story_cover.dart';

class LibraryGridStoryCard extends StatefulWidget {
  const LibraryGridStoryCard({
    super.key,
    required this.story,
    this.onTap,
    this.onLongPress,
  });

  final LibraryStory story;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  State<LibraryGridStoryCard> createState() => _LibraryGridStoryCardState();
}

class _LibraryGridStoryCardState extends State<LibraryGridStoryCard> {
  bool _pressed = false;

  static const _borderRadius = 20.0;

  void _setPressed(bool value) {
    if (_pressed == value) {
      return;
    }
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final category = LibraryPresentation.categoryLabel(story);
    final mood = LibraryPresentation.moodLabel(story);
    final isComplete = LibraryPresentation.isCompleted(story);

    return AnimatedScale(
      scale: _pressed ? 0.97 : 1,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOutCubic,
      child: Listener(
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            borderRadius: BorderRadius.circular(_borderRadius),
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.creamSurface,
                borderRadius: BorderRadius.circular(_borderRadius),
                border: Border.all(
                  color: AppColors.lavenderLight.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lavender.withValues(
                      alpha: _pressed ? 0.08 : 0.14,
                    ),
                    blurRadius: _pressed ? 8 : 16,
                    offset: Offset(0, _pressed ? 3 : 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 0.72,
                    child: Stack(
                      children: [
                        LibraryStoryCover(
                          story: story,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(_borderRadius),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: _CompletionIndicator(
                            progress: story.progress,
                            isComplete: isComplete,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                    height: 1.2,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _MiniBadge(label: category),
                            _MiniBadge(label: mood, isMood: true),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _RatingRow(rating: story.rating),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompletionIndicator extends StatelessWidget {
  const _CompletionIndicator({
    required this.progress,
    required this.isComplete,
  });

  final double progress;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.creamSurface.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.6),
        ),
      ),
      child: isComplete
          ? Icon(
              Icons.check_rounded,
              size: 16,
              color: const Color(0xFF4A7A5A),
            )
          : Padding(
              padding: const EdgeInsets.all(5),
              child: CircularProgressIndicator(
                value: progress > 0 ? progress : null,
                strokeWidth: 2.5,
                backgroundColor:
                    AppColors.lavenderLight.withValues(alpha: 0.4),
                color: AppColors.lavenderDark,
              ),
            ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({
    required this.label,
    this.isMood = false,
  });

  final String label;
  final bool isMood;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isMood
            ? AppColors.lavenderLight.withValues(alpha: 0.28)
            : const Color(0xFFFFF0E5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.lavenderDark,
              fontSize: 10,
            ),
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    if (rating <= 0) {
      return Text(
        'Not yet rated',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
      );
    }

    return Row(
      children: [
        const Text(
          '★',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFFE8C468),
            height: 1,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(width: 4),
        Text(
          'community',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
