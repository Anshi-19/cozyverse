import '../models/home_carousel_item.dart';

abstract final class HomeCarouselData {
  static const slides = [
    HomeCarouselItem(
      id: 'discover',
      imageAsset: 'assets/illustrations/banner_discover.png',
    ),
    HomeCarouselItem(
      id: 'continue',
      imageAsset: 'assets/illustrations/banner_continue.png',
    ),
    HomeCarouselItem(
      id: 'mood',
      imageAsset: 'assets/illustrations/banner_mood.png',
    ),
    HomeCarouselItem(
      id: 'trending',
      imageAsset: 'assets/illustrations/banner_trending.png',
    ),
  ];
}
