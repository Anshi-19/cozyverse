import '../models/library_story.dart';
import 'dummy_library_data.dart';

abstract final class LibraryRecentData {
  static final recentlyAdded = <LibraryStory>[
    DummyLibraryData.books[1],
    DummyLibraryData.movies[2],
    DummyLibraryData.series[0],
    DummyLibraryData.books[6],
    DummyLibraryData.movies[4],
  ];
}
