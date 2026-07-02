enum LibraryFilter {
  all,
  books,
  movies,
  series,
  completed,
  currentlyEnjoying,
  wishlist,
}

extension LibraryFilterLabel on LibraryFilter {
  String get label {
    return switch (this) {
      LibraryFilter.all => 'All',
      LibraryFilter.books => 'Books',
      LibraryFilter.movies => 'Movies',
      LibraryFilter.series => 'Series',
      LibraryFilter.completed => 'Completed',
      LibraryFilter.currentlyEnjoying => 'Currently Enjoying',
      LibraryFilter.wishlist => 'Wishlist',
    };
  }
}
