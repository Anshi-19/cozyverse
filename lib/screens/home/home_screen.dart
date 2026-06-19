import 'package:flutter/material.dart';

import '../../models/story_item.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/home_header_illustration.dart';
import '../../widgets/monthly_progress_card.dart';
import '../../widgets/mood_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/story_card.dart';
import '../../widgets/story_mood_card.dart';

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

  static const _exploreStories = [
    StoryItem(
      title: 'Harry Potter',
      category: 'Book',
      icon: Icons.auto_stories_rounded,
      gradientColors: [Color(0xFFE8DFF5), Color(0xFFD4C5E8)],
    ),
    StoryItem(
      title: 'Interstellar',
      category: 'Movie',
      icon: Icons.rocket_launch_rounded,
      gradientColors: [Color(0xFFFFF0E5), Color(0xFFE8DFF5)],
    ),
    StoryItem(
      title: 'Stranger Things',
      category: 'Series',
      icon: Icons.bolt_rounded,
      gradientColors: [Color(0xFFDDD0F0), Color(0xFFC5B4E3)],
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
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const HomeHeaderIllustration(),
                      const SizedBox(height: 20),
                      const _GreetingHeader(),
                      const SizedBox(height: 24),
                      const MoodCard(
                        moodLabel: 'Cozy ☕',
                        icon: Icons.nights_stay_rounded,
                      ),
                      const SizedBox(height: 20),
                      const StoryMoodCard(
                        moodTitle: '☕ Cozy Evening',
                        description:
                            'Perfect night for fantasy and comfort stories.',
                      ),
                      const SizedBox(height: 28),
                      const SectionHeader(title: 'Your Collection'),
                      const SizedBox(height: 14),
                      const _StatsRow(stats: _stats),
                      const SizedBox(height: 28),
                      const SectionHeader(title: 'Continue Exploring'),
                      const SizedBox(height: 14),
                      const _ExploreStoriesRow(stories: _exploreStories),
                      const SizedBox(height: 28),
                      const SectionHeader(title: 'Monthly Progress'),
                      const SizedBox(height: 14),
                      const MonthlyProgressCard(
                        completedCount: 8,
                        progress: 0.67,
                      ),
                      SizedBox(height: 24 + bottomPadding),
                    ]),
                  ),
                ),
              ],
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
          'Good Evening, Anshi ✨',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'What story are you living today?',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
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
        final spacing = 12.0;
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

class _ExploreStoriesRow extends StatelessWidget {
  const _ExploreStoriesRow({required this.stories});

  final List<StoryItem> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final story = stories[index];
          return StoryCard(
            title: story.title,
            category: story.category,
            icon: story.icon,
            gradientColors: story.gradientColors,
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
