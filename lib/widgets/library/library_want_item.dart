import 'package:flutter/material.dart';

import '../../data/library_presentation.dart';
import '../../models/story_tracker_item.dart';
import '../../theme/app_theme.dart';
import 'library_genre_chips.dart';
import 'library_story_cover.dart';

class LibraryWantItem extends StatefulWidget {
  const LibraryWantItem({
    super.key,
    required this.item,
    required this.onStart,
  });

  final StoryTrackerItem item;
  final VoidCallback onStart;

  @override
  State<LibraryWantItem> createState() => _LibraryWantItemState();
}

class _LibraryWantItemState extends State<LibraryWantItem> {
  bool _checking = false;

  Future<void> _handleCheck() async {
    setState(() => _checking = true);
    await Future<void>.delayed(const Duration(milliseconds: 220));
    if (!mounted) {
      return;
    }
    widget.onStart();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.item.story;
    final category = LibraryPresentation.categoryLabel(story);

    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 64,
              height: 86,
              child: LibraryStoryCover(
                story: story,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  category,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                LibraryGenreChips(story: story),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _SatisfyingCheckbox(
            isChecking: _checking,
            onTap: _checking ? null : _handleCheck,
          ),
        ],
      ),
    );
  }
}

class _SatisfyingCheckbox extends StatefulWidget {
  const _SatisfyingCheckbox({
    required this.isChecking,
    required this.onTap,
  });

  final bool isChecking;
  final VoidCallback? onTap;

  @override
  State<_SatisfyingCheckbox> createState() => _SatisfyingCheckboxState();
}

class _SatisfyingCheckboxState extends State<_SatisfyingCheckbox> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap == null
          ? null
          : (_) => setState(() => _pressed = true),
      onTapUp: widget.onTap == null
          ? null
          : (_) {
              setState(() => _pressed = false);
              widget.onTap!();
            },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.86 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isChecking
                ? AppColors.lavenderLight.withValues(alpha: 0.55)
                : AppColors.cream,
            border: Border.all(
              color: widget.isChecking
                  ? AppColors.lavenderDark
                  : AppColors.lavenderLight.withValues(alpha: 0.7),
              width: 2,
            ),
          ),
          child: widget.isChecking
              ? const Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: AppColors.lavenderDark,
                )
              : null,
        ),
      ),
    );
  }
}
