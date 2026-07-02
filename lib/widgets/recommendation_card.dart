import 'package:flutter/material.dart';

import '../../data/recommendation_presentation.dart';
import '../../models/recommendation.dart';
import '../../theme/app_theme.dart';
import 'recommendations/recommendation_genre_chip.dart';
import 'recommendations/recommendation_mood_match_box.dart';
import 'recommendations/recommendation_rating_row.dart';
import 'recommendations/recommendation_story_cover.dart';
import 'recommendations/recommendation_view_story_button.dart';

class RecommendationCard extends StatefulWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.moodId,
    this.width = 220,
    this.height = 400,
    this.onTap,
  });

  final Recommendation recommendation;
  final String moodId;
  final double width;
  final double height;
  final VoidCallback? onTap;

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  bool _pressed = false;

  static const _borderRadius = 24.0;

  void _setPressed(bool value) {
    if (_pressed == value) {
      return;
    }
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final recommendation = widget.recommendation;
    final genres = RecommendationPresentation.genresFor(recommendation);
    final rating = RecommendationPresentation.ratingFor(recommendation);
    final moodMatchText =
        RecommendationPresentation.moodMatchText(recommendation);
    final coverHeight = widget.height * 0.58;

    return AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.creamSurface,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            color: AppColors.lavenderLight.withValues(alpha: 0.55),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lavender.withValues(
                alpha: _pressed ? 0.1 : 0.18,
              ),
              blurRadius: _pressed ? 10 : 20,
              offset: Offset(0, _pressed ? 4 : 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: coverHeight,
                child: RecommendationStoryCover(
                  recommendation: recommendation,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(_borderRadius),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommendation.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                  letterSpacing: -0.2,
                                  height: 1.15,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: genres
                            .map(
                              (genre) => RecommendationGenreChip(
                                label: genre,
                                backgroundColor:
                                    RecommendationPresentation.chipColorFor(
                                  genre,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      RecommendationRatingRow(rating: rating),
                      const SizedBox(height: 10),
                      Expanded(
                        child: RecommendationMoodMatchBox(text: moodMatchText),
                      ),
                      const SizedBox(height: 10),
                      Listener(
                        onPointerDown: (_) => _setPressed(true),
                        onPointerUp: (_) => _setPressed(false),
                        onPointerCancel: (_) => _setPressed(false),
                        child: RecommendationViewStoryButton(
                          onPressed: widget.onTap,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
