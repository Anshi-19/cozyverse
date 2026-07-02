import 'package:flutter/material.dart';

import '../models/library_story.dart';
import 'mood_data.dart';

/// UI presentation helpers for library stories.
abstract final class LibraryPresentation {
  static const _genreOverrides = {
    'The Night Circus': ['Fantasy', 'Romance'],
    'Fourth Wing': ['Fantasy', 'Adventure'],
    'Atomic Habits': ['Non-Fiction', 'Self-Help'],
    'Project Hail Mary': ['Sci-Fi', 'Adventure'],
    'Dune': ['Sci-Fi', 'Adventure'],
    'Circe': ['Fantasy', 'Mythology'],
    'The Hobbit': ['Fantasy', 'Adventure'],
    'A Court of Thorns and Roses': ['Fantasy', 'Romance'],
    'Interstellar': ['Sci-Fi', 'Drama'],
    'La La Land': ['Romance', 'Drama'],
    'Spirited Away': ['Fantasy', 'Adventure'],
    'Dune: Part Two': ['Sci-Fi', 'Adventure'],
    'Everything Everywhere All at Once': ['Sci-Fi', 'Comedy'],
    'Barbie': ['Comedy', 'Adventure'],
    'Stranger Things': ['Mystery', 'Sci-Fi'],
    'The Bear': ['Drama', 'Comedy'],
    'Fleabag': ['Drama', 'Comedy'],
    'Bridgerton': ['Romance', 'Drama'],
    'Wednesday': ['Mystery', 'Comedy'],
    'The Last of Us': ['Drama', 'Adventure'],
    "Schitt's Creek": ['Comedy', 'Drama'],
  };

  static const _chipColors = {
    'Fantasy': Color(0xFFE8DFF5),
    'Adventure': Color(0xFFFFF0E5),
    'Romance': Color(0xFFFFE4F0),
    'Mystery': Color(0xFFEDE4F7),
    'Drama': Color(0xFFE3EDF7),
    'Comedy': Color(0xFFFFF5EC),
    'Sci-Fi': Color(0xFFDDD0F0),
    'Non-Fiction': Color(0xFFE8F0E8),
    'Self-Help': Color(0xFFFFF0E5),
    'Mythology': Color(0xFFF5EEFB),
  };

  static const _moodOverrides = {
    'The Night Circus': '✨ Magical',
    'Fourth Wing': '🔥 Intense',
    'Atomic Habits': '😌 Relaxed',
    'Project Hail Mary': '🚀 Sci-Fi',
    'Dune': '🚀 Sci-Fi',
    'Circe': '✨ Magical',
    'The Hobbit': '🌲 Adventure',
    'A Court of Thorns and Roses': '💕 Romantic',
    'Interstellar': '🚀 Sci-Fi',
    'La La Land': '💕 Romantic',
    'Spirited Away': '✨ Magical',
    'Dune: Part Two': '🚀 Sci-Fi',
    'Everything Everywhere All at Once': '✨ Magical',
    'Barbie': '😌 Relaxed',
    'Stranger Things': '🔥 Intense',
    'The Bear': '🔥 Intense',
    'Fleabag': '🌧 Melancholy',
    'Bridgerton': '💕 Romantic',
    'Wednesday': '✨ Magical',
    'The Last of Us': '🔥 Intense',
    "Schitt's Creek": '😌 Relaxed',
  };

  static List<String> genresFor(LibraryStory story) {
    return _genreOverrides[story.title] ??
        switch (story.type) {
          LibraryStoryType.book => const ['Fiction'],
          LibraryStoryType.movie => const ['Drama'],
          LibraryStoryType.series => const ['Drama'],
        };
  }

  static Color chipColorFor(String genre) {
    return _chipColors[genre] ?? const Color(0xFFF5EEFB);
  }

  static DateTime completedDateFor(LibraryStory story) {
    final hash = story.id.codeUnits.fold<int>(
      0,
      (total, unit) => total + unit,
    );
    return DateTime.now().subtract(Duration(days: hash % 120 + 1));
  }

  static String formattedCompletedDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Completed ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static String coverAssetPath(LibraryStory story) {
    final slug = story.title
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return 'assets/library/$slug.png';
  }

  static String categoryLabel(LibraryStory story) {
    return switch (story.type) {
      LibraryStoryType.book => 'Book',
      LibraryStoryType.movie => 'Movie',
      LibraryStoryType.series => 'Series',
    };
  }

  static String moodLabel(LibraryStory story) {
    if (_moodOverrides.containsKey(story.title)) {
      return _moodOverrides[story.title]!;
    }

    final hash = story.title.codeUnits.fold<int>(
      0,
      (total, unit) => total + unit,
    );
    final mood = MoodData.moods[hash % MoodData.moods.length];
    return mood.displayLabel;
  }

  static bool isCompleted(LibraryStory story) {
    return story.progress >= 1.0 ||
        story.status == 'Completed' ||
        story.status == 'Watched';
  }

  static bool isCurrentlyEnjoying(LibraryStory story) {
    return story.status == 'Reading' || story.status == 'Watching';
  }

  static bool isWishlist(LibraryStory story) {
    return story.status == 'Want To Read' ||
        story.status == 'Want To Watch';
  }
}
