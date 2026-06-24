import 'package:flutter/material.dart';

import '../../data/favorites_storage.dart';
import '../../data/mood_data.dart';
import '../../data/recommendation_data.dart';
import '../../models/recommendation.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/favorite_action_button.dart';
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

    return Scaffold(
      body: Stack(
        children: [
          const _StoryDetailBackground(),
          const DecorativeStars(),
          Column(
            children: [
              StoryDetailHero(recommendation: recommendation),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + bottomPadding),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Text(
                            recommendation.title,
                            style:
                                Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                      letterSpacing: -0.3,
                                    ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            recommendation.description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                          ),
                          const SizedBox(height: 24),
                          _MoodMatchSection(
                            moodLabel: moodLabel,
                            blurb: RecommendationData.moodMatchBlurbFor(
                              recommendation.moodId,
                            ),
                          ),
                          const SizedBox(height: 24),
                          StoryDetailsCard(
                            category: recommendation.category,
                            recommendedMood: moodLabel,
                            estimatedTime: RecommendationData.estimatedTimeFor(
                              recommendation,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: FavoriteActionButton(
                                  isFavorite: _isFavorite,
                                  onPressed:
                                      _isFavorite ? null : _toggleFavorite,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StoryActionButton(
                                  label: 'Add to Library',
                                  emoji: '📚',
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.lavenderDark,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Start This Story',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
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

class _MoodMatchSection extends StatelessWidget {
  const _MoodMatchSection({
    required this.moodLabel,
    required this.blurb,
  });

  final String moodLabel;
  final String blurb;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF3E8),
            Color(0xFFF5EEFB),
            Color(0xFFEDE4F7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavenderLight.withValues(alpha: 0.16),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mood Match',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            moodLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            blurb,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.45,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }
}

class _StoryActionButton extends StatelessWidget {
  const _StoryActionButton({
    required this.label,
    required this.emoji,
    required this.onPressed,
  });

  final String label;
  final String emoji;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        backgroundColor: AppColors.creamSurface,
        side: BorderSide(
          color: AppColors.lavenderLight.withValues(alpha: 0.7),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text('$emoji $label'),
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
