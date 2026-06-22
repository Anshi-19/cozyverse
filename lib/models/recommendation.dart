import 'package:flutter/material.dart';

class Recommendation {
  const Recommendation({
    required this.title,
    required this.category,
    required this.moodId,
    required this.description,
    required this.icon,
  });

  final String title;
  final String category;
  final String moodId;
  final String description;
  final IconData icon;
}
