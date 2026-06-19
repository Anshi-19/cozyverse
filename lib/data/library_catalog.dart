import '../data/dummy_library_data.dart';
import '../models/library_story.dart';

class LibraryCatalog {
  LibraryCatalog({
    required this.books,
    required this.movies,
    required this.series,
  });

  factory LibraryCatalog.fromDummyData() {
    return LibraryCatalog(
      books: List<LibraryStory>.of(DummyLibraryData.books),
      movies: List<LibraryStory>.of(DummyLibraryData.movies),
      series: List<LibraryStory>.of(DummyLibraryData.series),
    );
  }

  final List<LibraryStory> books;
  final List<LibraryStory> movies;
  final List<LibraryStory> series;

  void addStory(LibraryStory story) {
    switch (story.type) {
      case LibraryStoryType.book:
        books.insert(0, story);
      case LibraryStoryType.movie:
        movies.insert(0, story);
      case LibraryStoryType.series:
        series.insert(0, story);
    }
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
