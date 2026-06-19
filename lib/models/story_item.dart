import 'package:flutter/material.dart';

class StoryItem {
  const StoryItem({
    required this.title,
    required this.category,
    required this.icon,
    required this.gradientColors,
  });

  final String title;
  final String category;
  final IconData icon;
  final List<Color> gradientColors;
}
