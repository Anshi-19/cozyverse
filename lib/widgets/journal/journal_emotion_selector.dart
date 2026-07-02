import 'package:flutter/material.dart';

import '../../data/journal_emotion_data.dart';
import '../../models/journal_emotion.dart';
import '../../theme/app_theme.dart';

class JournalEmotionSelector extends StatelessWidget {
  const JournalEmotionSelector({
    super.key,
    required this.selectedEmotionId,
    required this.onSelected,
  });

  final String? selectedEmotionId;
  final ValueChanged<JournalEmotion> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: JournalEmotionData.emotions.map((emotion) {
        final isSelected = selectedEmotionId == emotion.id;

        return _EmotionChip(
          emotion: emotion,
          isSelected: isSelected,
          onTap: () => onSelected(emotion),
        );
      }).toList(),
    );
  }
}

class _EmotionChip extends StatelessWidget {
  const _EmotionChip({
    required this.emotion,
    required this.isSelected,
    required this.onTap,
  });

  final JournalEmotion emotion;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.04 : 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOutCubic,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.lavenderLight.withValues(alpha: 0.45)
              : AppColors.creamSurface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? AppColors.lavenderDark
                : AppColors.lavenderLight.withValues(alpha: 0.55),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.lavender.withValues(alpha: 0.16),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    emotion.emoji,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    emotion.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected
                              ? AppColors.lavenderDark
                              : AppColors.textPrimary,
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
