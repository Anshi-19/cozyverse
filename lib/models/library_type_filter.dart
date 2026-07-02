import '../models/library_story.dart';

enum LibraryTypeFilter {
  all,
  books,
  movies,
  series,
}

extension LibraryTypeFilterLabel on LibraryTypeFilter {
  String get label {
    return switch (this) {
      LibraryTypeFilter.all => 'All',
      LibraryTypeFilter.books => 'Books',
      LibraryTypeFilter.movies => 'Movies',
      LibraryTypeFilter.series => 'Series',
    };
  }

  bool matches(LibraryStory story) {
    return switch (this) {
      LibraryTypeFilter.all => true,
      LibraryTypeFilter.books => story.type == LibraryStoryType.book,
      LibraryTypeFilter.movies => story.type == LibraryStoryType.movie,
      LibraryTypeFilter.series => story.type == LibraryStoryType.series,
    };
  }
}
