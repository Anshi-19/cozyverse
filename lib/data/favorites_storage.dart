import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/favorite_story.dart';
import '../models/recommendation.dart';
import '../models/recommendation_serialization.dart';

class FavoritesStorage extends ChangeNotifier {
  FavoritesStorage._();

  static const _favoritesKey = 'favorite_stories';

  static final FavoritesStorage instance = FavoritesStorage._();

  SharedPreferences? _prefs;
  List<Recommendation> _favorites = [];

  List<FavoriteStory> get favorites => _favorites
      .map((recommendation) => FavoriteStory(recommendation: recommendation))
      .toList(growable: false);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _favorites = RecommendationSerialization.decodeList(
      _prefs!.getString(_favoritesKey),
    );
  }

  bool isFavorite(Recommendation recommendation) {
    return _favorites.any(
      (favorite) => favorite.favoriteId == recommendation.favoriteId,
    );
  }

  Future<bool> add(Recommendation recommendation) async {
    if (isFavorite(recommendation)) {
      return false;
    }

    _favorites = [recommendation, ..._favorites];
    await _persist();
    notifyListeners();
    return true;
  }

  Future<bool> remove(Recommendation recommendation) async {
    final updated = _favorites
        .where((favorite) => favorite.favoriteId != recommendation.favoriteId)
        .toList();

    if (updated.length == _favorites.length) {
      return false;
    }

    _favorites = updated;
    await _persist();
    notifyListeners();
    return true;
  }

  Future<void> _persist() async {
    await _prefs!.setString(
      _favoritesKey,
      RecommendationSerialization.encodeList(_favorites),
    );
  }
}
