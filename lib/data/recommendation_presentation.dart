import 'package:flutter/material.dart';

import '../models/recommendation.dart';

/// Presentation helpers for recommendation cards.
/// Keeps [RecommendationData] unchanged while supplying UI metadata.
abstract final class RecommendationPresentation {
  static const _genreOverrides = {
    'Harry Potter': ['Fantasy', 'Adventure'],
    'Gilmore Girls': ['Drama', 'Comedy'],
    'Anne of Green Gables': ['Drama', 'Romance'],
    'The Night Circus': ['Fantasy', 'Mystery'],
    'Stardust': ['Fantasy', 'Adventure'],
    'Spirited Away': ['Fantasy', 'Adventure'],
    'Interstellar': ['Sci-Fi', 'Drama'],
    'Dune': ['Sci-Fi', 'Adventure'],
    'Project Hail Mary': ['Sci-Fi', 'Adventure'],
    'Normal People': ['Drama', 'Romance'],
    'Atonement': ['Drama', 'Romance'],
    'The Perks of Being a Wallflower': ['Drama', 'Comedy'],
    'Pride and Prejudice': ['Romance', 'Drama'],
    'La La Land': ['Romance', 'Drama'],
    'Bridgerton': ['Romance', 'Drama'],
    'The Hobbit': ['Fantasy', 'Adventure'],
    'Indiana Jones': ['Adventure', 'Mystery'],
    'One Piece': ['Adventure', 'Comedy'],
    'Heartstopper': ['Romance', 'Drama'],
    'Little Forest': ['Drama', 'Comedy'],
    'Before Sunrise': ['Romance', 'Drama'],
    'Dark': ['Mystery', 'Drama'],
    'Breaking Bad': ['Drama', 'Mystery'],
    'Gone Girl': ['Mystery', 'Drama'],
  };

  static const _chipColors = {
    'Fantasy': Color(0xFFE8DFF5),
    'Adventure': Color(0xFFFFF0E5),
    'Romance': Color(0xFFFFE4F0),
    'Mystery': Color(0xFFEDE4F7),
    'Drama': Color(0xFFE3EDF7),
    'Comedy': Color(0xFFFFF5EC),
    'Sci-Fi': Color(0xFFDDD0F0),
  };

  static String coverAssetPath(Recommendation recommendation) {
    final slug = recommendation.title
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return 'assets/recommendations/$slug.png';
  }

  static List<String> genresFor(Recommendation recommendation) {
    return _genreOverrides[recommendation.title] ??
        switch (recommendation.category) {
          'Book' => const ['Fantasy'],
          'Movie' => const ['Adventure'],
          'Series' => const ['Drama'],
          _ => const ['Story'],
        };
  }

  static Color chipColorFor(String genre) {
    return _chipColors[genre] ?? const Color(0xFFF5EEFB);
  }

  static double ratingFor(Recommendation recommendation) {
    final hash = recommendation.title.codeUnits.fold<int>(
      0,
      (total, unit) => total + unit,
    );
    return 4.5 + (hash % 5) * 0.1;
  }

  static String moodMatchText(Recommendation recommendation) {
    return recommendation.description;
  }
}
