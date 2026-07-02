import '../models/recommendation.dart';

/// Local placeholder storage for personal story ratings.
class PersonalRatingStorage {
  PersonalRatingStorage._();

  static final PersonalRatingStorage instance = PersonalRatingStorage._();

  final Map<String, int> _ratings = {};

  int ratingFor(Recommendation recommendation) {
    return _ratings[recommendation.title] ?? 0;
  }

  void save(Recommendation recommendation, int rating) {
    _ratings[recommendation.title] = rating;
  }
}
