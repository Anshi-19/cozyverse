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

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.16),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          item.imageAsset,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
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
