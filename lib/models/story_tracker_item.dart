import '../models/library_story.dart';

enum StoryJourneyTab {
  wishlist,
  completed,
}

extension StoryJourneyTabLabel on StoryJourneyTab {
  String get label {
    return switch (this) {
      StoryJourneyTab.wishlist => 'Wishlist',
      StoryJourneyTab.completed => 'Completed',
    };
  }
}

class StoryTrackerItem {
  const StoryTrackerItem({
    required this.story,
    this.userRating = 0,
    this.completedDate,
  });

  final LibraryStory story;
  final int userRating;
  final DateTime? completedDate;

  StoryTrackerItem copyWith({
    LibraryStory? story,
    int? userRating,
    DateTime? completedDate,
  }) {
    return StoryTrackerItem(
      story: story ?? this.story,
      userRating: userRating ?? this.userRating,
      completedDate: completedDate ?? this.completedDate,
    );
  }
}
