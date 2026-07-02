class StoryJournalEntry {
  const StoryJournalEntry({
    required this.storyTitle,
    required this.reflections,
    required this.emotionId,
    required this.starRating,
    required this.favoriteMoment,
    required this.favoriteQuote,
    required this.savedAt,
  });

  final String storyTitle;
  final String reflections;
  final String emotionId;
  final int starRating;
  final String favoriteMoment;
  final String favoriteQuote;
  final DateTime savedAt;
}
