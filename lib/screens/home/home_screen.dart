import 'package:flutter/material.dart';

import '../../navigation/cozy_page_route.dart';
import '../../data/mood_data.dart';
import '../../data/mood_storage.dart';
import '../../data/recommendation_data.dart';
import '../../models/mood.dart';
import '../../models/recommendation.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cozy_card.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/home_carousel.dart';
import '../../widgets/monthly_progress_card.dart';
import '../../widgets/recommendation_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';
import '../story/story_detail_screen.dart';

abstract final class _HomeSpacing {
  static const horizontal = 24.0;
  static const top = 8.0;
  static const bottom = 28.0;
  static const afterGreeting = 20.0;
  static const afterCarousel = 24.0;
  static const afterMood = 32.0;
  static const sectionTitleGap = 10.0;
  static const afterSectionTitle = 16.0;
  static const majorSection = 36.0;
  static const minorSection = 28.0;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _stats = [
    (
      label: 'Books',
      value: 12,
      emoji: '📚',
      icon: Icons.menu_book_rounded,
      gradientColors: [Color(0xFFE8DFF5), Color(0xFFD4C5E8)],
      accentColor: Color(0xFFB8A9C9),
    ),
    (
      label: 'Movies',
      value: 23,
      emoji: '🎬',
      icon: Icons.movie_rounded,
      gradientColors: [Color(0xFFFFF0E5), Color(0xFFFFE4D6)],
      accentColor: Color(0xFFE8C4B0),
    ),
    (
      label: 'Series',
      value: 7,
      emoji: '📺',
      icon: Icons.live_tv_rounded,
      gradientColors: [Color(0xFFDDD0F0), Color(0xFFC5B4E3)],
      accentColor: Color(0xFFA898C4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        children: [
          const _HomeBackground(),
          const DecorativeStars(),
          SafeArea(
            child: ListenableBuilder(
              listenable: MoodStorage.instance,
              builder: (context, _) {
                final mood = MoodStorage.instance.selectedMood;

                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        _HomeSpacing.horizontal,
                        _HomeSpacing.top,
                        _HomeSpacing.horizontal,
                        _HomeSpacing.bottom + bottomPadding,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const _GreetingHeader(),
                          const SizedBox(height: _HomeSpacing.afterGreeting),
                          const HomeCarousel(),
                          const SizedBox(height: _HomeSpacing.afterCarousel),
                          _HomeMoodCard(mood: mood),
                          const SizedBox(height: _HomeSpacing.afterMood),
                          _HomeRecommendationsSection(
                            mood: mood,
                            onRecommendationTap: (recommendation) {
                              Navigator.of(context).push(
                                cozyPageRoute<void>(
                                  StoryDetailScreen(
                                    recommendation: recommendation,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: _HomeSpacing.majorSection),
                          const SectionHeader(title: 'Your Collection'),
                          const SizedBox(height: _HomeSpacing.sectionTitleGap),
                          const _StatsRow(stats: _stats),
                          const SizedBox(height: _HomeSpacing.minorSection),
                          const SectionHeader(title: 'Monthly Progress'),
                          const SizedBox(height: _HomeSpacing.sectionTitleGap),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: MonthlyProgressCard(
                              completedCount: 8,
                              progress: 0.67,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR STORY AWAITS',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.lavenderDark.withValues(alpha: 0.75),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
                fontSize: 11,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'Good Evening, Anshi ✨',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.6,
                height: 1.1,
              ),
        ),
        const SizedBox(height: 14),
        Container(
          width: 36,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: LinearGradient(
              colors: [
                AppColors.lavenderDark.withValues(alpha: 0.55),
                AppColors.lavenderLight.withValues(alpha: 0.25),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'What story are you living today?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                height: 1.45,
              ),
        ),
      ],
    );
  }
}

class _HomeMoodCard extends StatelessWidget {
  const _HomeMoodCard({required this.mood});

  final Mood mood;

  @override
  Widget build(BuildContext context) {
    final accent = MoodData.accentFor(mood);

    return CozyCard(
      padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          accent,
          AppColors.creamSurface.withValues(alpha: 0.92),
          const Color(0xFFF5EEFB),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.6),
              border: Border.all(
                color: AppColors.lavenderLight.withValues(alpha: 0.65),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              mood.emoji,
              style: const TextStyle(fontSize: 26),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mood.displayLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  mood.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.4,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => _HomeMoodPickerSheet.show(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.lavenderDark,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Change',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeMoodPickerSheet extends StatelessWidget {
  const _HomeMoodPickerSheet();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.creamSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const _HomeMoodPickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 20 + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lavenderLight.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Choose Your Mood',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 16),
          ...MoodData.moods.map((mood) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(mood.emoji, style: const TextStyle(fontSize: 24)),
              title: Text(
                mood.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              onTap: () {
                MoodStorage.instance.selectMood(mood);
                Navigator.of(context).pop();
              },
            );
          }),
        ],
      ),
    );
  }
}

class _HomeRecommendationsSection extends StatelessWidget {
  const _HomeRecommendationsSection({
    required this.mood,
    required this.onRecommendationTap,
  });

  final Mood mood;
  final ValueChanged<Recommendation> onRecommendationTap;

  @override
  Widget build(BuildContext context) {
    final recommendations = RecommendationData.forMood(mood.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '✨ Picked For Your Mood',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
                height: 1.15,
              ),
        ),
        const SizedBox(height: _HomeSpacing.sectionTitleGap),
        Text(
          'Stories chosen to match your current mood.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
        ),
        const SizedBox(height: _HomeSpacing.afterSectionTitle),
        _RecommendationsRow(
          recommendations: recommendations,
          moodId: mood.id,
          onRecommendationTap: onRecommendationTap,
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats});

  final List<
      ({
        String label,
        int value,
        String emoji,
        IconData icon,
        List<Color> gradientColors,
        Color accentColor,
      })> stats;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final cardWidth = (constraints.maxWidth - spacing * 2) / 3;

        return Row(
          children: List.generate(stats.length, (index) {
            final stat = stats[index];
            return Padding(
              padding: EdgeInsets.only(
                right: index < stats.length - 1 ? spacing : 0,
              ),
              child: SizedBox(
                width: cardWidth,
                child: StatCard(
                  label: stat.label,
                  value: stat.value,
                  emoji: stat.emoji,
                  icon: stat.icon,
                  gradientColors: stat.gradientColors,
                  accentColor: stat.accentColor,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _RecommendationsRow extends StatelessWidget {
  const _RecommendationsRow({
    required this.recommendations,
    required this.moodId,
    required this.onRecommendationTap,
  });

  final List<Recommendation> recommendations;
  final String moodId;
  final ValueChanged<Recommendation> onRecommendationTap;

  static const _cardWidth = 220.0;
  static const _rowHeight = 400.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _rowHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: recommendations.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return RecommendationCard(
            recommendation: recommendations[index],
            moodId: moodId,
            width: _cardWidth,
            onTap: () => onRecommendationTap(recommendations[index]),
          );
        },
      ),
    );
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: size.width * 0.55,
              height: size.width * 0.55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lavenderLight.withValues(alpha: 0.18),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.42,
            left: -50,
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFE8D6).withValues(alpha: 0.28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
