import 'package:flutter/material.dart';

import '../models/home_carousel_item.dart';
import '../theme/app_theme.dart';

abstract final class HomeCarouselData {
  static const slides = [
    HomeCarouselItem(
      id: 'discover',
      badge: '📚 DISCOVER',
      title: 'Discover New Stories',
      subtitle: 'Books • Movies • Series',
      imageAsset: 'assets/illustrations/banner_discover.png',
      gradientColors: [
        AppColors.lavenderLight,
        Color(0xFFE8DFF5),
        AppColors.lavender,
      ],
      illustrationPlaceholderIcon: Icons.auto_stories_rounded,
      accentColor: AppColors.lavenderDark,
      badgeBackgroundColor: Color(0xFFF5EEFB),
    ),
    HomeCarouselItem(
      id: 'continue',
      badge: '✨ FOR YOU',
      title: 'Continue Your Journey',
      subtitle: 'Pick up where you left off',
      imageAsset: 'assets/illustrations/banner_continue.png',
      gradientColors: [
        Color(0xFFFFF3E8),
        Color(0xFFFFE4D6),
        Color(0xFFFFD6C8),
      ],
      illustrationPlaceholderIcon: Icons.play_circle_rounded,
      accentColor: Color(0xFFE8A882),
      badgeBackgroundColor: Color(0xFFFFF0E5),
    ),
    HomeCarouselItem(
      id: 'mood',
      badge: '🌙 MOOD MATCH',
      title: 'Stories For Your Mood',
      subtitle: 'Cozy • Magical • Adventure',
      imageAsset: 'assets/illustrations/banner_mood.png',
      gradientColors: [
        Color(0xFFE8F0E8),
        Color(0xFFD8EDDF),
        Color(0xFFC8E6D0),
      ],
      illustrationPlaceholderIcon: Icons.auto_awesome_rounded,
      accentColor: Color(0xFF4A7A5A),
      badgeBackgroundColor: Color(0xFFEEF6F0),
    ),
    HomeCarouselItem(
      id: 'trending',
      badge: '🔥 TRENDING',
      title: 'Trending This Week',
      subtitle: 'Find your next obsession',
      imageAsset: 'assets/illustrations/banner_trending.png',
      gradientColors: [
        Color(0xFFDDD0F0),
        Color(0xFFC5B4E3),
        Color(0xFFB8A9C9),
      ],
      illustrationPlaceholderIcon: Icons.local_fire_department_rounded,
      accentColor: AppColors.lavenderDark,
      badgeBackgroundColor: Color(0xFFEDE4F7),
    ),
  ];
}
