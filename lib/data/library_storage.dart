import 'package:shared_preferences/shared_preferences.dart';

import '../models/library_story.dart';
import '../models/library_story_serialization.dart';

class LibraryStorage {
  LibraryStorage._();

  static const _userStoriesKey = 'user_library_stories';

  static SharedPreferences? _prefs;
  static List<LibraryStory> _userStories = [];

  static List<LibraryStory> get userStories => List.unmodifiable(_userStories);

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _userStories = LibraryStorySerialization.decodeList(
      _prefs!.getString(_userStoriesKey),
    );
  }

  static Future<void> saveUserStories(List<LibraryStory> stories) async {
    _userStories = List<LibraryStory>.of(stories);
    await _prefs!.setString(
      _userStoriesKey,
      LibraryStorySerialization.encodeList(_userStories),
    );
  }
}
