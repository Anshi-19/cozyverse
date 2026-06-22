import 'recommendation.dart';
import 'recommendation_serialization.dart';

class FavoriteStory {
  const FavoriteStory({required this.recommendation});

  final Recommendation recommendation;

  String get id => recommendation.favoriteId;

  String get title => recommendation.title;

  String get category => recommendation.category;

  String get moodId => recommendation.moodId;

  String get description => recommendation.description;
}
