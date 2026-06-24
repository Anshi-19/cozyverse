import 'package:flutter/material.dart';

import '../../navigation/cozy_page_route.dart';
import '../../theme/app_theme.dart';
import '../app_shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pages = [
    _OnboardingPageData(
      title: 'Track Your Stories',
      subtitle:
          'Keep all your books, movies and TV shows in one magical place.',
      icon: Icons.menu_book_rounded,
      accent: Color(0xFFE8DFF5),
    ),
    _OnboardingPageData(
      title: 'Discover By Mood',
      subtitle: 'Find stories that match your current vibe and emotions.',
      icon: Icons.auto_awesome_rounded,
      accent: Color(0xFFF0E6FA),
    ),
    _OnboardingPageData(
      title: 'Build Your CozyVerse',
      subtitle: 'Create your own story-filled universe.',
      icon: Icons.cottage_rounded,
      accent: Color(0xFFDDD0F0),
    ),
  ];

  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      cozyPageRoute<void>(const AppShell()),
    );
  }

  void _goToNextPage() {
    if (_currentPage == _pages.length - 1) {
      _finishOnboarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        children: [
          const _OnboardingBackground(),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _finishOnboarding,
                    child: const Text('Skip'),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return _OnboardingPage(
                        data: _pages[index],
                        isActive: index == _currentPage,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 16 + bottomPadding),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      children: [
                        _OnboardingPageIndicator(
                          count: _pages.length,
                          currentIndex: _currentPage,
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: _goToNextPage,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.lavenderDark,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              isLastPage ? 'Get Started' : 'Next',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
}

class _OnboardingBackground extends StatelessWidget {
  const _OnboardingBackground();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cream,
            Color(0xFFFFF3E8),
            Color(0xFFF5EEFB),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.08,
            right: -40,
            child: _GlowOrb(
              size: size.width * 0.45,
              color: AppColors.lavenderLight.withValues(alpha: 0.35),
            ),
          ),
          Positioned(
            bottom: size.height * 0.18,
            left: -60,
            child: _GlowOrb(
              size: size.width * 0.55,
              color: const Color(0xFFFFE8D6).withValues(alpha: 0.5),
            ),
          ),
          Positioned(
            top: size.height * 0.32,
            left: size.width * 0.12,
            child: Icon(
              Icons.star_rounded,
              size: 18,
              color: AppColors.lavender.withValues(alpha: 0.45),
            ),
          ),
          Positioned(
            top: size.height * 0.22,
            right: size.width * 0.2,
            child: Icon(
              Icons.auto_awesome,
              size: 14,
              color: AppColors.lavenderDark.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.data,
    required this.isActive,
  });

  final _OnboardingPageData data;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconSize = MediaQuery.sizeOf(context).width.clamp(280.0, 480.0) * 0.34;

    return AnimatedOpacity(
      opacity: isActive ? 1 : 0.7,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isActive ? 1 : 0.92,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      data.accent,
                      data.accent.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.35, 0.7, 1],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lavender.withValues(alpha: 0.25),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Icon(
                  data.icon,
                  size: iconSize * 0.38,
                  color: AppColors.lavenderDark,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.06),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                height: 1.55,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageIndicator extends StatelessWidget {
  const _OnboardingPageIndicator({
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive
                ? AppColors.lavenderDark
                : AppColors.lavenderLight.withValues(alpha: 0.7),
          ),
        );
      }),
    );
  }
}
