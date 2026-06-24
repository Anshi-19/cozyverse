import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'illustration_placeholder.dart';

/// Profile screen header illustration slot.
class ProfileHeaderIllustration extends StatelessWidget {
  const ProfileHeaderIllustration({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final height = illustrationHeight(context, min: 150, max: 190);

    return IllustrationPlaceholder(
      height: height,
      borderRadius: 22,
      gradientColors: const [
        Color(0xFFF5EEFB),
        Color(0xFFFFF3E8),
        Color(0xFFFFF8F0),
      ],
      decorations: [
        const IllustrationGlowOrb(
          size: 110,
          color: Color(0xFFE8DFF5),
          top: -20,
          right: -16,
        ),
        const IllustrationGlowOrb(
          size: 84,
          color: Color(0xFFFFE4F0),
          bottom: -18,
          left: -10,
        ),
        const IllustrationStar(size: 11, top: 22, left: 32, opacity: 0.5),
        const IllustrationStar(size: 9, top: 40, left: 210, opacity: 0.4),
        const IllustrationStar(size: 8, top: 58, left: 88, opacity: 0.32),
        Positioned(
          top: 16,
          right: 28,
          child: Icon(
            Icons.auto_awesome,
            size: 18,
            color: AppColors.lavenderDark.withValues(alpha: 0.35),
          ),
        ),
        Center(
          child: child ??
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.lavenderLight.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.creamSurface.withValues(alpha: 0.85),
                          AppColors.lavenderLight.withValues(alpha: 0.35),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.lavenderLight.withValues(alpha: 0.65),
                      ),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      size: 36,
                      color: AppColors.lavenderDark.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
        ),
        Positioned(
          bottom: 20,
          left: 40,
          child: Text(
            '🌸',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.lavenderDark.withValues(alpha: 0.4),
            ),
          ),
        ),
        Positioned(
          bottom: 18,
          right: 44,
          child: Text(
            '✨',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.lavenderDark.withValues(alpha: 0.38),
            ),
          ),
        ),
      ],
    );
  }
}
