import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HomeHeaderIllustration extends StatelessWidget {
  const HomeHeaderIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3D3558),
              Color(0xFF5C4F7A),
              Color(0xFF8B7BA8),
              Color(0xFFD4C5E8),
              Color(0xFFFFF0E5),
            ],
            stops: [0.0, 0.25, 0.5, 0.78, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lavender.withValues(alpha: 0.28),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned(
                top: 18,
                right: 28,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFFF8E8),
                        const Color(0xFFFFF8E8).withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFF8E8).withValues(alpha: 0.5),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.nightlight_round,
                    size: 36,
                    color: Color(0xFFFFF3C4),
                  ),
                ),
              ),
              const Positioned(
                top: 22,
                left: 36,
                child: _TwinkleStar(size: 12, opacity: 0.85),
              ),
              const Positioned(
                top: 42,
                left: 88,
                child: _TwinkleStar(size: 8, opacity: 0.6),
              ),
              const Positioned(
                top: 30,
                right: 110,
                child: _TwinkleStar(size: 10, opacity: 0.7),
              ),
              const Positioned(
                top: 56,
                right: 52,
                child: Icon(
                  Icons.auto_awesome,
                  size: 14,
                  color: Color(0xFFFFF8E8),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.lavenderLight.withValues(alpha: 0.25),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 14,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.park_rounded,
                      size: 28,
                      color: const Color(0xFF6B9B7A).withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.creamSurface.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.lavenderLight.withValues(alpha: 0.7),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lavenderDark.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.cottage_rounded,
                        size: 40,
                        color: AppColors.lavenderDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.park_rounded,
                      size: 22,
                      color: const Color(0xFF6B9B7A).withValues(alpha: 0.55),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                left: 24,
                child: Icon(
                  Icons.cloud_rounded,
                  size: 20,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 30,
                child: Icon(
                  Icons.cloud_rounded,
                  size: 26,
                  color: Colors.white.withValues(alpha: 0.28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TwinkleStar extends StatelessWidget {
  const _TwinkleStar({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_rounded,
      size: size,
      color: const Color(0xFFFFF8E8).withValues(alpha: opacity),
    );
  }
}
