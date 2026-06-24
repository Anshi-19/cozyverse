import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'illustration_placeholder.dart';

/// Home screen hero illustration slot.
///
/// Replace the placeholder [Icon] with a transparent PNG via [child] when ready.
class HeroIllustration extends StatelessWidget {
  const HeroIllustration({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final height = heroIllustrationHeight(context);

    return IllustrationPlaceholder(
      height: height,
      gradientColors: const [
        Color(0xFFF8F2FC),
        Color(0xFFF5EEFB),
        Color(0xFFFFF3E8),
        Color(0xFFFFF8F0),
      ],
      decorations: [
        const IllustrationGlowOrb(
          size: 120,
          color: Color(0xFFD4C5E8),
          top: -24,
          right: -18,
        ),
        const IllustrationGlowOrb(
          size: 90,
          color: Color(0xFFFFE4D6),
          bottom: -20,
          left: -12,
        ),
        const IllustrationStar(size: 12, top: 22, left: 36, opacity: 0.55),
        const IllustrationStar(size: 8, top: 42, left: 88, opacity: 0.4),
        const IllustrationStar(size: 10, top: 30, left: 220, opacity: 0.45),
        Positioned(
          top: 18,
          right: 28,
          child: Icon(
            Icons.nightlight_round,
            size: 34,
            color: AppColors.lavenderDark.withValues(alpha: 0.35),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.park_rounded,
                size: 24,
                color: const Color(0xFF6B9B7A).withValues(alpha: 0.45),
              ),
              const SizedBox(width: 10),
              Container(
  width: 320,
  height: 240,
  clipBehavior: Clip.hardEdge,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(18),
  ),
  child: child ??
      Image.asset(
        'assets/illustrations/home_cottage.png',
        fit: BoxFit.cover,
      ),
),
              const SizedBox(width: 10),
              Icon(
                Icons.park_rounded,
                size: 20,
                color: const Color(0xFF6B9B7A).withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 24,
          child: Icon(
            Icons.cloud_rounded,
            size: 18,
            color: AppColors.lavenderLight.withValues(alpha: 0.55),
          ),
        ),
        Positioned(
          bottom: 14,
          right: 30,
          child: Icon(
            Icons.cloud_rounded,
            size: 24,
            color: AppColors.lavenderLight.withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }
}
