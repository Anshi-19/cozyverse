import 'package:flutter/material.dart';

import '../../data/recommendation_presentation.dart';
import '../../models/recommendation.dart';
import '../recommendations/recommendation_genre_chip.dart';

class StoryDetailGenresRow extends StatelessWidget {
  const StoryDetailGenresRow({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final genres = RecommendationPresentation.genresFor(recommendation);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres
          .map(
            (genre) => RecommendationGenreChip(
              label: genre,
              backgroundColor: RecommendationPresentation.chipColorFor(genre),
            ),
          )
          .toList(),
    );
  }
}
