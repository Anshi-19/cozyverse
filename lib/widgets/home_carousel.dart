import 'dart:async';

import 'package:flutter/material.dart';

import '../data/home_carousel_data.dart';
import '../models/home_carousel_item.dart';
import '../theme/app_theme.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({
    super.key,
    this.items = HomeCarouselData.slides,
    this.height = 185,
    this.autoScrollInterval = const Duration(seconds: 5),
  });

  final List<HomeCarouselItem> items;
  final double height;
  final Duration autoScrollInterval;

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  static const _virtualItemCount = 10000;

  late final PageController _pageController;
  late Timer _autoScrollTimer;

  int _currentPage = 0;

  int get _itemCount => widget.items.length;

  int get _initialPage {
    final middle = _virtualItemCount ~/ 2;
    return middle - (middle % _itemCount);
  }

  @override
  void initState() {
    super.initState();
    _currentPage = _initialPage;
    _pageController = PageController(initialPage: _initialPage);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int _itemIndexForPage(int page) => page % _itemCount;

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollInterval, (_) {
      if (!_pageController.hasClients || !mounted) {
        return;
      }

      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _resetAutoScroll() {
    _autoScrollTimer.cancel();
    _startAutoScroll();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    _resetAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final activeIndex = _itemIndexForPage(_currentPage);

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _virtualItemCount,
            itemBuilder: (context, index) {
              final item = widget.items[_itemIndexForPage(index)];
              return _HomeCarouselSlide(item: item);
            },
          ),
        ),
        const SizedBox(height: 12),
        _HomeCarouselIndicators(
          count: _itemCount,
          activeIndex: activeIndex,
        ),
      ],
    );
  }
}

class _HomeCarouselSlide extends StatelessWidget {
  const _HomeCarouselSlide({required this.item});

  final HomeCarouselItem item;

  Color get _accentColor => item.accentColor ?? AppColors.lavenderDark;

  Color get _badgeBackground =>
      item.badgeBackgroundColor ??
      AppColors.creamSurface.withValues(alpha: 0.85);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: item.gradientColors,
        ),
        border: Border.all(
          color: _accentColor.withValues(alpha: 0.28),
        ),
        boxShadow: [
          BoxShadow(
            color: _accentColor.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _CarouselGlowCircle(
              size: 88,
              color: _accentColor,
              top: -22,
              right: 48,
            ),
            _CarouselGlowCircle(
              size: 64,
              color: item.gradientColors.last,
              bottom: -18,
              left: -10,
            ),
            const Positioned(
              top: 14,
              left: 20,
              child: _CarouselSparkle(size: 10, opacity: 0.4),
            ),
            Positioned(
              top: 34,
              left: 118,
              child: Icon(
                Icons.star_rounded,
                size: 8,
                color: _accentColor.withValues(alpha: 0.32),
              ),
            ),
            Positioned(
              bottom: 22,
              left: 148,
              child: Icon(
                Icons.auto_awesome,
                size: 9,
                color: _accentColor.withValues(alpha: 0.28),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CarouselFeatureBadge(
                          label: item.badge,
                          backgroundColor: _badgeBackground,
                          accentColor: _accentColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.3,
                                height: 1.15,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                                height: 1.35,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  _CarouselIllustrationSlot(
                    item: item,
                    accentColor: _accentColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselFeatureBadge extends StatelessWidget {
  const _CarouselFeatureBadge({
    required this.label,
    required this.backgroundColor,
    required this.accentColor,
  });

  final String label;
  final Color backgroundColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.22),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: accentColor,
              letterSpacing: 0.6,
              fontSize: 10,
            ),
      ),
    );
  }
}

class _CarouselIllustrationSlot extends StatelessWidget {
  const _CarouselIllustrationSlot({
    required this.item,
    required this.accentColor,
  });

  final HomeCarouselItem item;
  final Color accentColor;

  static const _slotSize = 90.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _slotSize,
      height: _slotSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.creamSurface.withValues(alpha: 0.88),
            AppColors.creamSurface.withValues(alpha: 0.55),
          ],
        ),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 8,
              right: 10,
              child: Icon(
                Icons.star_rounded,
                size: 9,
                color: accentColor.withValues(alpha: 0.35),
              ),
            ),
            if (item.imageAsset != null)
              Image.asset(
                item.imageAsset!,
                width: _slotSize,
                height: _slotSize,
                fit: BoxFit.contain,
              )
            else
              Icon(
                item.illustrationPlaceholderIcon,
                size: 36,
                color: accentColor.withValues(alpha: 0.72),
              ),
          ],
        ),
      ),
    );
  }
}

class _CarouselGlowCircle extends StatelessWidget {
  const _CarouselGlowCircle({
    required this.size,
    required this.color,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final double size;
  final Color color;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.28),
              color.withValues(alpha: 0.06),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class _CarouselSparkle extends StatelessWidget {
  const _CarouselSparkle({
    required this.size,
    required this.opacity,
  });

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.auto_awesome,
      size: size,
      color: AppColors.lavenderDark.withValues(alpha: opacity),
    );
  }
}

class _HomeCarouselIndicators extends StatelessWidget {
  const _HomeCarouselIndicators({
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 22 : 6,
          height: isActive ? 7 : 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: isActive
                ? AppColors.lavenderDark
                : AppColors.lavenderLight.withValues(alpha: 0.45),
          ),
        );
      }),
    );
  }
}
