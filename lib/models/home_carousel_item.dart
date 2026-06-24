import 'package:flutter/material.dart';

class HomeCarouselItem {
  const HomeCarouselItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.gradientColors,
    required this.illustrationPlaceholderIcon,
    this.imageAsset,
    this.accentColor,
    this.badgeBackgroundColor,
  });

  final String id;
  final String title;
  final String subtitle;
  final String badge;
  final List<Color> gradientColors;
  final IconData illustrationPlaceholderIcon;
  final String? imageAsset;
  final Color? accentColor;
  final Color? badgeBackgroundColor;
}
