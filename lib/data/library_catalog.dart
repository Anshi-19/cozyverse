import 'dummy_library_data.dart';
import '../models/library_story.dart';
import 'library_storage.dart';

class LibraryCatalog {
  LibraryCatalog._({
    required List<LibraryStory> userBooks,
    required List<LibraryStory> userMovies,
    required List<LibraryStory> userSeries,
  })  : _userBooks = userBooks,
        _userMovies = userMovies,
        _userSeries = userSeries {
    _refreshVisibleLists();
  }

  final List<LibraryStory> _userBooks;
  final List<LibraryStory> _userMovies;
  final List<LibraryStory> _userSeries;

  late List<LibraryStory> books;
  late List<LibraryStory> movies;
  late List<LibraryStory> series;

  factory LibraryCatalog.create() {
    final storedStories = LibraryStorage.userStories;

    return LibraryCatalog._(
      userBooks: storedStories
          .where((story) => story.type == LibraryStoryType.book)
          .toList(),
      userMovies: storedStories
          .where((story) => story.type == LibraryStoryType.movie)
          .toList(),
      userSeries: storedStories
          .where((story) => story.type == LibraryStoryType.series)
          .toList(),
    );
  }

  void _refreshVisibleLists() {
    books = [..._userBooks, ...DummyLibraryData.books];
    movies = [..._userMovies, ...DummyLibraryData.movies];
    series = [..._userSeries, ...DummyLibraryData.series];
  }

  Future<void> addStory(LibraryStory story) async {
    switch (story.type) {
      case LibraryStoryType.book:
        _userBooks.insert(0, story);
      case LibraryStoryType.movie:
        _userMovies.insert(0, story);
      case LibraryStoryType.series:
        _userSeries.insert(0, story);
    }

    _refreshVisibleLists();
    await LibraryStorage.saveUserStories(_userStories);
  }

  List<LibraryStory> get _userStories => [
        ..._userBooks,
        ..._userMovies,
        ..._userSeries,
      ];

  bool isUserStory(LibraryStory story) {
    return _userStories.any((entry) => entry.id == story.id);
  }

  Future<void> updateStory(LibraryStory updated) async {
    final location = _findUserStoryLocation(updated.id);
    if (location == null) {
      return;
    }

    location.list.removeAt(location.index);

    final targetList = _userListForType(updated.type);
    if (location.type == updated.type) {
      targetList.insert(location.index, updated);
    } else {
      targetList.insert(0, updated);
    }

    _refreshVisibleLists();
    await LibraryStorage.saveUserStories(_userStories);
  }

  Future<bool> deleteStory(LibraryStory story) async {
    final location = _findUserStoryLocation(story.id);
    if (location == null) {
      return false;
    }

    location.list.removeAt(location.index);
    _refreshVisibleLists();
    await LibraryStorage.saveUserStories(_userStories);
    return true;
  }

  ({List<LibraryStory> list, int index, LibraryStoryType type})?
      _findUserStoryLocation(String id) {
    for (final entry in [
      (list: _userBooks, type: LibraryStoryType.book),
      (list: _userMovies, type: LibraryStoryType.movie),
      (list: _userSeries, type: LibraryStoryType.series),
    ]) {
      final index = entry.list.indexWhere((story) => story.id == id);
      if (index != -1) {
        return (list: entry.list, index: index, type: entry.type);
      }
    }
    return null;
  }

  List<LibraryStory> _userListForType(LibraryStoryType type) {
    return switch (type) {
      LibraryStoryType.book => _userBooks,
      LibraryStoryType.movie => _userMovies,
      LibraryStoryType.series => _userSeries,
    };
  }

  static String nextId(LibraryStoryType type) {
    final prefix = switch (type) {
      LibraryStoryType.book => 'book',
      LibraryStoryType.movie => 'movie',
      LibraryStoryType.series => 'series',
    };
    return '$prefix-${DateTime.now().millisecondsSinceEpoch}';
  }
}
