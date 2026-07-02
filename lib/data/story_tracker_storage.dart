import 'package:flutter/foundation.dart';

import '../models/library_story.dart';
import '../models/story_tracker_item.dart';
import 'dummy_library_data.dart';
import 'library_presentation.dart';

/// Local in-memory story journey tracker.
class StoryTrackerStorage extends ChangeNotifier {
  StoryTrackerStorage._() {
    _initializeFromPlaceholderData();
  }

  static final StoryTrackerStorage instance = StoryTrackerStorage._();

  final List<StoryTrackerItem> _wishlist = [];
  final List<StoryTrackerItem> _completed = [];

  List<StoryTrackerItem> get wishlist => List.unmodifiable(_wishlist);

  List<StoryTrackerItem> get completed => List.unmodifiable(_completed);

  int countFor(StoryJourneyTab tab) {
    return switch (tab) {
      StoryJourneyTab.wishlist => _wishlist.length,
      StoryJourneyTab.completed => _completed.length,
    };
  }

  List<StoryTrackerItem> itemsFor(StoryJourneyTab tab) {
    return switch (tab) {
      StoryJourneyTab.wishlist => wishlist,
      StoryJourneyTab.completed => completed,
    };
  }

  void _initializeFromPlaceholderData() {
    final allStories = [
      ...DummyLibraryData.books,
      ...DummyLibraryData.movies,
      ...DummyLibraryData.series,
    ];

    for (final story in allStories) {
      final item = StoryTrackerItem(
        story: story,
        userRating: story.rating > 0 ? story.rating.round().clamp(1, 5) : 0,
        completedDate: LibraryPresentation.isCompleted(story)
            ? LibraryPresentation.completedDateFor(story)
            : null,
      );

      if (LibraryPresentation.isCompleted(story)) {
        _completed.add(item);
      } else if (LibraryPresentation.isWishlist(story) ||
          LibraryPresentation.isCurrentlyEnjoying(story)) {
        _wishlist.add(item);
      }
    }
  }

  void startStory(String storyId) {
    final index = _wishlist.indexWhere((item) => item.story.id == storyId);
    if (index == -1) {
      return;
    }

    final item = _wishlist.removeAt(index);
    final updatedStory = _storyWithStage(
      item.story,
      stage: _CompletedStage(),
    );

    _completed.insert(
      0,
      item.copyWith(
        story: updatedStory,
        completedDate: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void updateUserRating(String storyId, int rating) {
    for (final list in [_wishlist, _completed]) {
      final index = list.indexWhere((item) => item.story.id == storyId);
      if (index != -1) {
        list[index] = list[index].copyWith(userRating: rating);
        notifyListeners();
        return;
      }
    }
  }

  LibraryStory _storyWithStage(
    LibraryStory story, {
    required _StoryStage stage,
  }) {
    return LibraryStory(
      id: story.id,
      title: story.title,
      status: stage.statusFor(story.type),
      rating: story.rating,
      progress: stage.progress,
      icon: story.icon,
      gradientColors: story.gradientColors,
      type: story.type,
    );
  }
}

sealed class _StoryStage {
  double get progress;
  String statusFor(LibraryStoryType type);
}

class _CompletedStage implements _StoryStage {
  @override
  double get progress => 1.0;

  @override
  String statusFor(LibraryStoryType type) {
    return switch (type) {
      LibraryStoryType.book => 'Completed',
      LibraryStoryType.movie => 'Watched',
      LibraryStoryType.series => 'Completed',
    };
  }
}
