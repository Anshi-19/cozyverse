import 'package:flutter/material.dart';

import '../models/mood.dart';

abstract final class MoodData {
  static const defaultMoodId = 'cozy';

  static const moods = [
    Mood(
      id: 'cozy',
      name: 'Cozy',
      emoji: '☕',
      description: 'Perfect for comfort stories and warm evenings.',
    ),
    Mood(
      id: 'magical',
      name: 'Magical',
      emoji: '✨',
      description: 'Ideal for enchanted worlds and whimsical adventures.',
    ),
    Mood(
      id: 'sci-fi',
      name: 'Sci-Fi',
      emoji: '🚀',
      description: 'Explore futuristic worlds and possibilities.',
    ),
    Mood(
      id: 'melancholy',
      name: 'Melancholy',
      emoji: '🌧',
      description: 'Reflective tales for quiet, thoughtful moments.',
    ),
    Mood(
      id: 'romantic',
      name: 'Romantic',
      emoji: '💕',
      description: 'Love stories that warm the heart and soul.',
    ),
    Mood(
      id: 'adventure',
      name: 'Adventure',
      emoji: '🌲',
      description: 'Epic journeys through wild and unknown lands.',
    ),
    Mood(
      id: 'relaxed',
      name: 'Relaxed',
      emoji: '😌',
      description: 'Easygoing stories for a calm, peaceful day.',
    ),
    Mood(
      id: 'intense',
      name: 'Intense',
      emoji: '🔥',
      description: 'Gripping narratives that keep you on the edge.',
    ),
  ];

  static Mood get defaultMood =>
      moods.firstWhere((mood) => mood.id == defaultMoodId);

  static Mood? findById(String id) {
    for (final mood in moods) {
      if (mood.id == id) {
        return mood;
      }
    }
    return null;
  }

  static IconData iconFor(Mood mood) {
    return switch (mood.id) {
      'cozy' => Icons.local_cafe_rounded,
      'magical' => Icons.auto_awesome_rounded,
      'sci-fi' => Icons.rocket_launch_rounded,
      'melancholy' => Icons.water_drop_rounded,
      'romantic' => Icons.favorite_rounded,
      'adventure' => Icons.park_rounded,
      'relaxed' => Icons.spa_rounded,
      'intense' => Icons.local_fire_department_rounded,
      _ => Icons.mood_rounded,
    };
  }

  static Color accentFor(Mood mood) {
    return switch (mood.id) {
      'cozy' => const Color(0xFFFFF0E5),
      'magical' => const Color(0xFFF5EEFB),
      'sci-fi' => const Color(0xFFE8DFF5),
      'melancholy' => const Color(0xFFE3EDF7),
      'romantic' => const Color(0xFFFFE4F0),
      'adventure' => const Color(0xFFE8F0E8),
      'relaxed' => const Color(0xFFFFF5EC),
      'intense' => const Color(0xFFFFE8E0),
      _ => const Color(0xFFF5EEFB),
    };
  }
}
