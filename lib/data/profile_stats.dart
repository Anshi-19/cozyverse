import '../models/achievement.dart';
import '../models/library_story.dart';
import '../models/mood.dart';
import 'favorites_storage.dart';
import 'library_catalog.dart';
import 'library_storage.dart';
import 'mood_storage.dart';

class ProfileStats {
  const ProfileStats({
    required this.storiesAdded,
    required this.favoritesCount,
    required this.currentMood,
    required this.completedStories,
    required this.totalBooks,
    required this.totalMovies,
    required this.totalSeries,
    required this.achievements,
  });

  final int storiesAdded;
  final int favoritesCount;
  final Mood currentMood;
  final int completedStories;
  final int totalBooks;
  final int totalMovies;
  final int totalSeries;
  final List<Achievement> achievements;

  factory ProfileStats.fromCatalog(LibraryCatalog catalog) {
    final allStories = [
      ...catalog.books,
      ...catalog.movies,
      ...catalog.series,
    ];

    return ProfileStats(
      storiesAdded: LibraryStorage.userStories.length,
      favoritesCount: FavoritesStorage.instance.favorites.length,
      currentMood: MoodStorage.instance.selectedMood,
      completedStories: allStories.where(_isCompleted).length,
      totalBooks: catalog.books.length,
      totalMovies: catalog.movies.length,
      totalSeries: catalog.series.length,
      achievements: _buildAchievements(catalog),
    );
  }

  static bool _isCompleted(LibraryStory story) {
    return story.status == 'Completed' || story.status == 'Watched';
  }

  static List<Achievement> _buildAchievements(LibraryCatalog catalog) {
    final favoritesCount = FavoritesStorage.instance.favorites.length;
    final exploredMoodCount = MoodStorage.instance.exploredMoodCount;

    return [
      Achievement(
        id: 'first_story',
        title: 'First Story Added',
        emoji: '🏆',
        isUnlocked: LibraryStorage.userStories.isNotEmpty,
      ),
      Achievement(
        id: 'collector',
        title: 'Collector',
        emoji: '❤️',
        isUnlocked: favoritesCount >= 5,
      ),
      Achievement(
        id: 'bookworm',
        title: 'Bookworm',
        emoji: '📚',
        isUnlocked: catalog.books.length >= 10,
      ),
      Achievement(
        id: 'movie_buff',
        title: 'Movie Buff',
        emoji: '🎬',
        isUnlocked: catalog.movies.length >= 10,
      ),
      Achievement(
        id: 'mood_explorer',
        title: 'Mood Explorer',
        emoji: '🌙',
        isUnlocked: exploredMoodCount >= 3,
      ),
    ];
  }
}
