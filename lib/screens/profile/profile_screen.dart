import 'package:flutter/material.dart';

import '../../models/achievement.dart';
import '../../data/favorites_storage.dart';
import '../../data/library_catalog.dart';
import '../../data/mood_storage.dart';
import '../../data/profile_stats.dart';
import '../../theme/app_theme.dart';
import '../../widgets/achievement_card.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/illustrations/profile_header_illustration.dart';
import '../../widgets/profile_current_mood_card.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/profile_stat_card.dart';
import '../../widgets/reading_journey_card.dart';
import '../../widgets/section_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.isActive = false});

  final bool isActive;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LibraryCatalog _catalog = LibraryCatalog.create();

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      setState(() => _catalog = LibraryCatalog.create());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        children: [
          const _ProfileBackground(),
          const DecorativeStars(),
          SafeArea(
            child: ListenableBuilder(
              listenable: Listenable.merge([
                MoodStorage.instance,
                FavoritesStorage.instance,
              ]),
              builder: (context, _) {
                final stats = ProfileStats.fromCatalog(_catalog);

                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + bottomPadding),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const ProfileHeaderIllustration(),
                          const SizedBox(height: 20),
                          const ProfileHeader(),
                          const SizedBox(height: 28),
                          const SectionHeader(title: 'Your Stats'),
                          const SizedBox(height: 14),
                          _StatsGrid(stats: stats),
                          const SizedBox(height: 28),
                          const SectionHeader(title: 'Reading Journey'),
                          const SizedBox(height: 14),
                          ReadingJourneyCard(
                            totalBooks: stats.totalBooks,
                            totalMovies: stats.totalMovies,
                            totalSeries: stats.totalSeries,
                          ),
                          const SizedBox(height: 28),
                          const SectionHeader(title: 'Achievements'),
                          const SizedBox(height: 14),
                          _AchievementsGrid(achievements: stats.achievements),
                          const SizedBox(height: 28),
                          const SectionHeader(title: 'Current Mood'),
                          const SizedBox(height: 14),
                          ProfileCurrentMoodCard(mood: stats.currentMood),
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

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});

  final ProfileStats stats;

  @override
  Widget build(BuildContext context) {
    final cards = [
      (
        label: 'Stories Added',
        value: '${stats.storiesAdded}',
        emoji: '📚',
        gradientColors: [const Color(0xFFE8DFF5), const Color(0xFFD4C5E8)],
        accentColor: const Color(0xFFB8A9C9),
      ),
      (
        label: 'Favorites',
        value: '${stats.favoritesCount}',
        emoji: '❤️',
        gradientColors: [const Color(0xFFFFE4F0), const Color(0xFFFFD6E8)],
        accentColor: const Color(0xFFE07A7A),
      ),
      (
        label: 'Current Mood',
        value: stats.currentMood.displayLabel,
        emoji: '🌙',
        gradientColors: [const Color(0xFFF5EEFB), const Color(0xFFEDE4F7)],
        accentColor: const Color(0xFFB8A9C9),
      ),
      (
        label: 'Completed Stories',
        value: '${stats.completedStories}',
        emoji: '✅',
        gradientColors: [const Color(0xFFE8F0E8), const Color(0xFFD8EDDF)],
        accentColor: const Color(0xFF4A7A5A),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final cardWidth = (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards.map((card) {
            return SizedBox(
              width: cardWidth,
              child: ProfileStatCard(
                label: card.label,
                value: card.value,
                emoji: card.emoji,
                gradientColors: card.gradientColors,
                accentColor: card.accentColor,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _AchievementsGrid extends StatelessWidget {
  const _AchievementsGrid({required this.achievements});

  final List<Achievement> achievements;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final cardWidth = (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: achievements.map((achievement) {
            return SizedBox(
              width: cardWidth,
              child: AchievementCard(achievement: achievement),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ProfileBackground extends StatelessWidget {
  const _ProfileBackground();

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
            top: -40,
            right: -30,
            child: Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lavenderLight.withValues(alpha: 0.2),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.15,
            left: -50,
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFE8D6).withValues(alpha: 0.25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
