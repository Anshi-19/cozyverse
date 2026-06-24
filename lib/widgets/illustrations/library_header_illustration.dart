import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'illustration_placeholder.dart';

/// Library screen header illustration slot.
class LibraryHeaderIllustration extends StatelessWidget {
  const LibraryHeaderIllustration({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final height = illustrationHeight(context, min: 140, max: 180);

    return IllustrationPlaceholder(
      height: height,
      borderRadius: 22,
      gradientColors: const [
        Color(0xFFFFF8F0),
        Color(0xFFE8DFF5),
        Color(0xFFFFF0E5),
      ],
      decorations: [
        const IllustrationGlowOrb(
          size: 96,
          color: Color(0xFFD4C5E8),
          top: -14,
          right: -12,
        ),
        const IllustrationGlowOrb(
          size: 72,
          color: Color(0xFFFFE4D6),
          bottom: -12,
          left: -6,
        ),
        const IllustrationStar(size: 10, top: 18, left: 24, opacity: 0.48),
        const IllustrationStar(size: 8, top: 36, left: 180, opacity: 0.38),
        Positioned(
          bottom: 20,
          left: 28,
          child: Icon(
            Icons.menu_book_rounded,
            size: 22,
            color: AppColors.lavenderDark.withValues(alpha: 0.3),
          ),
        ),
        Positioned(
          bottom: 24,
          right: 32,
          child: Icon(
            Icons.movie_rounded,
            size: 20,
            color: AppColors.lavenderDark.withValues(alpha: 0.28),
          ),
        ),
        Center(
          child: child ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _BookStack(
                    colors: const [Color(0xFFE8DFF5), Color(0xFFD4C5E8)],
                    icon: Icons.auto_stories_rounded,
                    width: 52,
                    height: 68,
                    rotation: -0.08,
                  ),
                  Transform.translate(
                    offset: const Offset(-8, -6),
                    child: _BookStack(
                      colors: const [Color(0xFFFFF0E5), Color(0xFFFFE4D6)],
                      icon: Icons.movie_rounded,
                      width: 48,
                      height: 62,
                      rotation: 0.06,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-12, 2),
                    child: _BookStack(
                      colors: const [Color(0xFFEDE4F7), Color(0xFFD4C5E8)],
                      icon: Icons.live_tv_rounded,
                      width: 46,
                      height: 58,
                      rotation: -0.04,
                    ),
                  ),
                ],
              ),
        ),
      ],
    );
  }
}

class _BookStack extends StatelessWidget {
  const _BookStack({
    required this.colors,
    required this.icon,
    required this.width,
    required this.height,
    required this.rotation,
  });

  final List<Color> colors;
  final IconData icon;
  final double width;
  final double height;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          border: Border.all(
            color: AppColors.lavenderLight.withValues(alpha: 0.6),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.last.withValues(alpha: 0.22),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 24,
          color: AppColors.lavenderDark.withValues(alpha: 0.65),
        ),
      ),
    );
  }
}
