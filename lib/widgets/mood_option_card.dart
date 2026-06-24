import 'package:flutter/material.dart';

import '../data/mood_data.dart';
import '../models/mood.dart';
import '../theme/app_theme.dart';

class MoodOptionCard extends StatelessWidget {
  const MoodOptionCard({
    super.key,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = MoodData.accentFor(mood);

    return AnimatedScale(
      scale: isSelected ? 1.03 : 1,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.lavenderDark
                    : AppColors.lavenderLight.withValues(alpha: 0.55),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.lavender.withValues(alpha: 0.22)
                      : AppColors.lavender.withValues(alpha: 0.08),
                  blurRadius: isSelected ? 14 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(22),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: AnimatedScale(
        scale: isSelected ? 1.08 : 1,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubic,
        child: Image.asset(
          'assets/illustrations/mood_${mood.id}.png',
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) {
            return Text(
              mood.emoji,
              style: const TextStyle(fontSize: 32),
            );
          },
        ),
      ),
    ),

    
  ],
),
          ),
        ),
      ),
    );
  }
}
