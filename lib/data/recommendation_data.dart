import 'package:flutter/material.dart';

import '../models/recommendation.dart';

abstract final class RecommendationData {
  static const all = [
    // Cozy
    Recommendation(
      title: 'Harry Potter',
      category: 'Book',
      moodId: 'cozy',
      description: 'A warm magical world perfect for curling up with tea.',
      icon: Icons.auto_stories_rounded,
    ),
    Recommendation(
      title: 'Gilmore Girls',
      category: 'Series',
      moodId: 'cozy',
      description: 'Small-town charm, wit, and endless coffee refills.',
      icon: Icons.local_cafe_rounded,
    ),
    Recommendation(
      title: 'Anne of Green Gables',
      category: 'Book',
      moodId: 'cozy',
      description: 'Gentle countryside comfort and hopeful hearts.',
      icon: Icons.eco_rounded,
    ),
    // Magical
    Recommendation(
      title: 'The Night Circus',
      category: 'Book',
      moodId: 'magical',
      description: 'A dreamlike circus lit by wonder and mystery.',
      icon: Icons.nightlight_round,
    ),
    Recommendation(
      title: 'Stardust',
      category: 'Movie',
      moodId: 'magical',
      description: 'A starlit quest through enchanted skies.',
      icon: Icons.star_rounded,
    ),
    Recommendation(
      title: 'Spirited Away',
      category: 'Movie',
      moodId: 'magical',
      description: 'A spellbinding journey through spirit and wonder.',
      icon: Icons.temple_buddhist_rounded,
    ),
    // Sci-Fi
    Recommendation(
      title: 'Interstellar',
      category: 'Movie',
      moodId: 'sci-fi',
      description: 'Love and physics across the stars.',
      icon: Icons.rocket_launch_rounded,
    ),
    Recommendation(
      title: 'Dune',
      category: 'Book',
      moodId: 'sci-fi',
      description: 'Epic sands, prophecy, and distant futures.',
      icon: Icons.landscape_rounded,
    ),
    Recommendation(
      title: 'Project Hail Mary',
      category: 'Book',
      moodId: 'sci-fi',
      description: 'Science, survival, and unlikely friendship.',
      icon: Icons.biotech_rounded,
    ),
    // Melancholy
    Recommendation(
      title: 'Normal People',
      category: 'Book',
      moodId: 'melancholy',
      description: 'Quiet longing in ordinary, aching lives.',
      icon: Icons.favorite_border_rounded,
    ),
    Recommendation(
      title: 'Atonement',
      category: 'Movie',
      moodId: 'melancholy',
      description: 'A haunting tale of love and regret.',
      icon: Icons.water_drop_rounded,
    ),
    Recommendation(
      title: 'The Perks of Being a Wallflower',
      category: 'Book',
      moodId: 'melancholy',
      description: 'Tender coming-of-age in letters and mixtapes.',
      icon: Icons.mail_rounded,
    ),
    // Romantic
    Recommendation(
      title: 'Pride and Prejudice',
      category: 'Book',
      moodId: 'romantic',
      description: 'Sparkling wit and timeless romance.',
      icon: Icons.local_florist_rounded,
    ),
    Recommendation(
      title: 'La La Land',
      category: 'Movie',
      moodId: 'romantic',
      description: 'Music, dreams, and star-crossed love.',
      icon: Icons.music_note_rounded,
    ),
    Recommendation(
      title: 'Bridgerton',
      category: 'Series',
      moodId: 'romantic',
      description: 'Regency balls, secrets, and swooning hearts.',
      icon: Icons.favorite_rounded,
    ),
    // Adventure
    Recommendation(
      title: 'The Hobbit',
      category: 'Book',
      moodId: 'adventure',
      description: 'A cozy quest through mountains and magic.',
      icon: Icons.forest_rounded,
    ),
    Recommendation(
      title: 'Indiana Jones',
      category: 'Movie',
      moodId: 'adventure',
      description: 'Whip-cracking relic hunts and daring escapes.',
      icon: Icons.explore_rounded,
    ),
    Recommendation(
      title: 'One Piece',
      category: 'Series',
      moodId: 'adventure',
      description: 'Grand voyages, crew, and boundless wonder.',
      icon: Icons.sailing_rounded,
    ),
    // Relaxed
    Recommendation(
      title: 'Heartstopper',
      category: 'Series',
      moodId: 'relaxed',
      description: 'Soft, sunny days and gentle friendship.',
      icon: Icons.wb_sunny_rounded,
    ),
    Recommendation(
      title: 'Little Forest',
      category: 'Movie',
      moodId: 'relaxed',
      description: 'Slow living, home cooking, and quiet seasons.',
      icon: Icons.cottage_rounded,
    ),
    Recommendation(
      title: 'Before Sunrise',
      category: 'Movie',
      moodId: 'relaxed',
      description: 'One night of wandering talk and connection.',
      icon: Icons.nightlight_outlined,
    ),
    // Intense
    Recommendation(
      title: 'Dark',
      category: 'Series',
      moodId: 'intense',
      description: 'Time-twisted secrets in a shadowed town.',
      icon: Icons.bolt_rounded,
    ),
    Recommendation(
      title: 'Breaking Bad',
      category: 'Series',
      moodId: 'intense',
      description: 'A gripping descent into moral darkness.',
      icon: Icons.local_fire_department_rounded,
    ),
    Recommendation(
      title: 'Gone Girl',
      category: 'Book',
      moodId: 'intense',
      description: 'A twisty thriller of trust and deception.',
      icon: Icons.psychology_rounded,
    ),
  ];

  static List<Recommendation> forMood(String moodId) {
    return all.where((recommendation) => recommendation.moodId == moodId).toList();
  }

  static String headingFor(String moodId) {
    return switch (moodId) {
      'cozy' => 'Perfect picks for a cozy evening ☕',
      'magical' => 'Whimsical wonders await you ✨',
      'sci-fi' => 'Explore new worlds tonight 🚀',
      'melancholy' => 'Quiet stories for reflection 🌧',
      'romantic' => 'Stories full of heart 💕',
      'adventure' => 'Epic journeys ahead 🌲',
      'relaxed' => 'Easy picks for tonight 😌',
      'intense' => 'Stories that grip you 🔥',
      _ => 'Recommended for tonight',
    };
  }

  static List<Color> gradientForCategory(String category) {
    return switch (category) {
      'Book' => [const Color(0xFFE8DFF5), const Color(0xFFD4C5E8)],
      'Movie' => [const Color(0xFFFFF0E5), const Color(0xFFFFE4D6)],
      'Series' => [const Color(0xFFDDD0F0), const Color(0xFFC5B4E3)],
      _ => [const Color(0xFFF5EEFB), const Color(0xFFE8DFF5)],
    };
  }

  static String moodMatchBlurbFor(String moodId) {
    return switch (moodId) {
      'cozy' =>
        'This story is perfect for warm evenings, comfort, and escapism.',
      'magical' =>
        'Ideal when you want wonder, enchantment, and a touch of magic.',
      'sci-fi' => 'Perfect for exploring bold futures and expansive worlds.',
      'melancholy' =>
        'A thoughtful pick for quiet reflection and deep feeling.',
      'romantic' => 'Made for heartfelt moments and stories of love.',
      'adventure' => 'Great for epic quests and journeys into the unknown.',
      'relaxed' => 'A gentle choice for calm days and peaceful viewing.',
      'intense' => 'Best when you want gripping drama and high stakes.',
      _ => 'A wonderful match for your current story mood.',
    };
  }

  static String estimatedTimeFor(Recommendation recommendation) {
    return switch (recommendation.category) {
      'Book' => '6–8 hours',
      'Movie' => '2–3 hours',
      'Series' => 'Season 1 · 8 hours',
      _ => '2–4 hours',
    };
  }
}
