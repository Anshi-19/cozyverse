import 'dart:math' show pi, sin;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DecorativeStars extends StatefulWidget {
  const DecorativeStars({super.key});

  static const _stars = [
    (top: 0.08, left: 0.12, size: 10.0, opacity: 0.35),
    (top: 0.14, left: 0.78, size: 14.0, opacity: 0.45),
    (top: 0.22, left: 0.42, size: 8.0, opacity: 0.3),
    (top: 0.31, left: 0.88, size: 11.0, opacity: 0.4),
    (top: 0.38, left: 0.18, size: 9.0, opacity: 0.28),
    (top: 0.48, left: 0.62, size: 12.0, opacity: 0.32),
    (top: 0.55, left: 0.08, size: 10.0, opacity: 0.38),
    (top: 0.62, left: 0.74, size: 9.0, opacity: 0.3),
    (top: 0.71, left: 0.34, size: 13.0, opacity: 0.42),
    (top: 0.78, left: 0.52, size: 8.0, opacity: 0.25),
    (top: 0.84, left: 0.22, size: 11.0, opacity: 0.35),
    (top: 0.9, left: 0.86, size: 10.0, opacity: 0.3),
  ];

  @override
  State<DecorativeStars> createState() => _DecorativeStarsState();
}

class _DecorativeStarsState extends State<DecorativeStars>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            children: DecorativeStars._stars.asMap().entries.map((entry) {
              final index = entry.key;
              final star = entry.value;
              final phase = (_controller.value * 2 * pi) + (index * 0.85);
              final twinkle = 0.55 + (0.45 * sin(phase));
              final opacity = star.opacity * twinkle;

              return Positioned(
                top: size.height * star.top,
                left: size.width * star.left,
                child: Icon(
                  Icons.star_rounded,
                  size: star.size,
                  color: AppColors.lavenderDark.withValues(alpha: opacity),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
