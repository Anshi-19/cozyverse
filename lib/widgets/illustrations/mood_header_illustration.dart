import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'illustration_placeholder.dart';

/// Mood screen header illustration slot.
class MoodHeaderIllustration extends StatelessWidget {
  const MoodHeaderIllustration({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final height = illustrationHeight(context, min: 150, max: 190);

    return IllustrationPlaceholder(
      height: height,
      borderRadius: 22,
      gradientColors: const [
        Color(0xFFFFF8F0),
        Color(0xFFF5EEFB),
        Color(0xFFEDE4F7),
      ],
      decorations: [
        const IllustrationGlowOrb(
          size: 100,
          color: Color(0xFFE8DFF5),
          top: -18,
          left: -10,
        ),
        const IllustrationGlowOrb(
          size: 80,
          color: Color(0xFFFFE4F0),
          bottom: -16,
          right: -8,
        ),
        const IllustrationStar(size: 11, top: 20, left: 28, opacity: 0.5),
        const IllustrationStar(size: 8, top: 48, left: 72, opacity: 0.35),
        const IllustrationStar(size: 10, top: 24, left: 200, opacity: 0.42),
        Positioned(
          top: 20,
          right: 24,
          child: Icon(
            Icons.auto_awesome,
            size: 22,
            color: AppColors.lavenderDark.withValues(alpha: 0.35),
          ),
        ),
        Center(
          child: child ??
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.creamSurface.withValues(alpha: 0.7),
                  border: Border.all(
                    color: AppColors.lavenderLight.withValues(alpha: 0.6),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lavender.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 40,
                  color: AppColors.lavenderDark.withValues(alpha: 0.65),
                ),
              ),
        ),
        Positioned(
          bottom: 18,
          left: 32,
          child: Text(
            '✨',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.lavenderDark.withValues(alpha: 0.45),
            ),
          ),
        ),
        Positioned(
          bottom: 22,
          right: 36,
          child: Text(
            '🌙',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.lavenderDark.withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    );
  }
}
