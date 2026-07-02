import 'package:flutter/foundation.dart';

import '../models/story_journal_entry.dart';

/// Local in-memory placeholder storage for journal entries.
class JournalStorage extends ChangeNotifier {
  JournalStorage._();

  static final JournalStorage instance = JournalStorage._();

  final List<StoryJournalEntry> _entries = [];

  List<StoryJournalEntry> get entries =>
      List.unmodifiable(_entries);

  StoryJournalEntry? entryForStory(String storyTitle) {
    for (final entry in _entries) {
      if (entry.storyTitle == storyTitle) {
        return entry;
      }
    }
    return null;
  }

  void save(StoryJournalEntry entry) {
    _entries.removeWhere(
      (existing) => existing.storyTitle == entry.storyTitle,
    );
    _entries.insert(0, entry);
    notifyListeners();
  }
}
