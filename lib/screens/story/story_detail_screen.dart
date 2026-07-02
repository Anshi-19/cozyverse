import 'package:flutter/material.dart';

import '../../data/favorites_storage.dart';
import '../../data/mood_data.dart';
import '../../data/personal_rating_storage.dart';
import '../../data/recommendation_data.dart';
import '../../data/recommendation_presentation.dart';
import '../../models/recommendation.dart';
import '../../navigation/cozy_page_route.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';
import '../journal/story_journal_screen.dart';
import '../../widgets/story_detail/story_detail_action_bar.dart';
import '../../widgets/story_detail/story_detail_community_rating.dart';
import '../../widgets/story_detail/story_detail_genres_row.dart';
import '../../widgets/story_detail/story_detail_mood_section.dart';
import '../../widgets/story_detail/story_detail_personal_rating.dart';
import '../../widgets/story_detail/story_detail_quote_card.dart';
import '../../widgets/story_detail/story_detail_section.dart';
import '../../widgets/story_detail_hero.dart';
import '../../widgets/story_details_card.dart';

class StoryDetailScreen extends StatefulWidget {
  const StoryDetailScreen({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    FavoritesStorage.instance.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    FavoritesStorage.instance.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    setState(() {});
  }

  bool get _isFavorite =>
      FavoritesStorage.instance.isFavorite(widget.recommendation);

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      return;
    }

    final added =
        await FavoritesStorage.instance.add(widget.recommendation);
    if (!mounted || !added) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to Favorites'),
        backgroundColor: AppColors.lavenderDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendation = widget.recommendation;
    final mood = MoodData.findById(recommendation.moodId);
    final moodLabel = mood?.displayLabel ?? recommendation.moodId;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final rating = RecommendationPresentation.ratingFor(recommendation);

    return Scaffold(
      body: Stack(
        children: [
          const _StoryDetailBackground(),
          const DecorativeStars(),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: StoryDetailHero(recommendation: recommendation),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -28),
                  child: _StoryDetailPage(
                    recommendation: recommendation,
                    moodLabel: moodLabel,
                    rating: rating,
                    isFavorite: _isFavorite,
                    onFavoritePressed: _isFavorite ? null : _toggleFavorite,
                    onStartStory: () {
                      Navigator.of(context).push(
                        cozyPageRoute(
                          StoryJournalScreen(
                            recommendation: recommendation,
                          ),
                        ),
                      );
                    },
                    bottomPadding: bottomPadding,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: AppColors.creamSurface.withValues(alpha: 0.92),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: AppColors.lavenderDark,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryDetailPage extends StatefulWidget {
  const _StoryDetailPage({
    required this.recommendation,
    required this.moodLabel,
    required this.rating,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onStartStory,
    required this.bottomPadding,
  });

  final Recommendation recommendation;
  final String moodLabel;
  final double rating;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;
  final VoidCallback onStartStory;
  final double bottomPadding;

  @override
  State<_StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<_StoryDetailPage> {
  late int _personalRating;

  static const _horizontalPadding = 24.0;
  static const _sectionGap = 28.0;

  @override
  void initState() {
    super.initState();
    _personalRating =
        PersonalRatingStorage.instance.ratingFor(widget.recommendation);
  }

  void _updatePersonalRating(int rating) {
    setState(() => _personalRating = rating);
    PersonalRatingStorage.instance.save(widget.recommendation, rating);
  }

  @override
  Widget build(BuildContext context) {
    final recommendation = widget.recommendation;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.14),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          _horizontalPadding,
          8,
          _horizontalPadding,
          28 + widget.bottomPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lavenderLight.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              recommendation.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.4,
                    height: 1.15,
                  ),
            ),
            const SizedBox(height: 20),
            StoryDetailCommunityRating(rating: widget.rating),
            const SizedBox(height: 20),
            StoryDetailPersonalRating(
              rating: _personalRating,
              onRatingChanged: _updatePersonalRating,
            ),
            const SizedBox(height: _sectionGap),
            StoryDetailSection(
              title: 'Genres',
              child: StoryDetailGenresRow(recommendation: recommendation),
            ),
            const SizedBox(height: _sectionGap),
            StoryDetailSection(
              title: 'Story Information',
              child: StoryDetailsCard(
                category: recommendation.category,
                recommendedMood: widget.moodLabel,
                estimatedTime: RecommendationData.estimatedTimeFor(
                  recommendation,
                ),
              ),
            ),
            const SizedBox(height: _sectionGap),
            StoryDetailSection(
              title: 'About This Story',
              child: Text(
                recommendation.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.6,
                    ),
              ),
            ),
            const SizedBox(height: _sectionGap),
            StoryDetailMoodSection(
              moodLabel: widget.moodLabel,
              blurb: RecommendationData.moodMatchBlurbFor(
                recommendation.moodId,
              ),
              matchText: RecommendationPresentation.moodMatchText(
                recommendation,
              ),
            ),
            const SizedBox(height: _sectionGap),
            const StoryDetailQuoteCard(),
            const SizedBox(height: 32),
            StoryDetailActionBar(
              isFavorite: widget.isFavorite,
              onFavoritePressed: widget.onFavoritePressed,
              onAddToLibrary: () {},
              onStartStory: widget.onStartStory,
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryDetailBackground extends StatelessWidget {
  const _StoryDetailBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cream,
            Color(0xFFFFF5EC),
            Color(0xFFF8F2FC),
          ],
        ),
      ),
    );
  }
}
