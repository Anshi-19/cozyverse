import 'package:flutter/material.dart';

import '../../navigation/cozy_page_route.dart';
import '../../data/favorites_storage.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/favorite_story_card.dart';
import '../story/story_detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _SavedBackground(),
          const DecorativeStars(),
          SafeArea(
            child: ListenableBuilder(
              listenable: FavoritesStorage.instance,
              builder: (context, _) {
                final favorites = FavoritesStorage.instance.favorites;

                if (favorites.isEmpty) {
                  return const _SavedEmptyState();
                }

                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const _SavedHeader(),
                          const SizedBox(height: 24),
                          ...favorites.map(
                            (favorite) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: FavoriteStoryCard(
                                favorite: favorite,
                                onTap: () {
                                  Navigator.of(context).push(
                                    cozyPageRoute<void>(
                                      StoryDetailScreen(
                                        recommendation: favorite.recommendation,
                                      ),
                                    ),
                                  );
                                },
                                onRemove: () {
                                  FavoritesStorage.instance
                                      .remove(favorite.recommendation);
                                },
                              ),
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

class _SavedHeader extends StatelessWidget {
  const _SavedHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lavenderLight.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: Color(0xFFE07A7A),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '❤️ Saved Stories',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your personal cozy collection',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SavedEmptyState extends StatelessWidget {
  const _SavedEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF3E8),
                    Color(0xFFF5EEFB),
                    Color(0xFFEDE4F7),
                  ],
                ),
                border: Border.all(
                  color: AppColors.lavenderLight.withValues(alpha: 0.55),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lavenderLight.withValues(alpha: 0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 24,
                    right: 36,
                    child: Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: AppColors.lavenderDark.withValues(alpha: 0.45),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 40,
                    child: Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: AppColors.lavenderDark.withValues(alpha: 0.35),
                    ),
                  ),
                  const Icon(
                    Icons.favorite_rounded,
                    size: 56,
                    color: Color(0xFFE07A7A),
                  ),
                  Positioned(
                    bottom: 28,
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 28,
                      color: AppColors.lavenderDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              '❤️ No Saved Stories Yet',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              "Save recommendations you love and they'll appear here.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedBackground extends StatelessWidget {
  const _SavedBackground();

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
        ],
      ),
    );
  }
}
