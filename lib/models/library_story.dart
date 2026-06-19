import 'package:flutter/material.dart';

enum LibraryStoryType { book, movie, series }

class LibraryStory {
  const LibraryStory({
    required this.id,
    required this.title,
    required this.status,
    required this.rating,
    required this.progress,
    required this.icon,
    required this.gradientColors,
    required this.type,
  });

  final String id;
  final String title;
  final String status;
  final double rating;
  final double progress;
  final IconData icon;
  final List<Color> gradientColors;
  final LibraryStoryType type;
}
