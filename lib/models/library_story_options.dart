import 'package:flutter/material.dart';

import '../models/library_story.dart';

abstract final class LibraryStoryStatuses {
  static List<String> forType(LibraryStoryType type) {
    return switch (type) {
      LibraryStoryType.book => ['Reading', 'Completed', 'Want To Read'],
      LibraryStoryType.movie => ['Watched', 'Want To Watch'],
      LibraryStoryType.series => ['Watching', 'Completed', 'Want To Watch'],
    };
  }
}

abstract final class LibraryStoryDefaults {
  static ({IconData icon, List<Color> gradientColors}) forType(
    LibraryStoryType type,
  ) {
    return switch (type) {
      LibraryStoryType.book => (
          icon: Icons.menu_book_rounded,
          gradientColors: [Color(0xFFE8DFF5), Color(0xFFD4C5E8)],
        ),
      LibraryStoryType.movie => (
          icon: Icons.movie_rounded,
          gradientColors: [Color(0xFFFFF0E5), Color(0xFFFFE4D6)],
        ),
      LibraryStoryType.series => (
          icon: Icons.live_tv_rounded,
          gradientColors: [Color(0xFFDDD0F0), Color(0xFFC5B4E3)],
        ),
    };
  }
}
