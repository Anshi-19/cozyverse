import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class LibraryEmptyState extends StatelessWidget {
  const LibraryEmptyState({super.key});

  static const _illustrationPath =
      'assets/illustrations/library_empty_bookshelf.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              _illustrationPath,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFF0E5),
                        Color(0xFFE8DFF5),
                        Color(0xFFEDE4F7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.lavenderLight.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shelves,
                        size: 48,
                        color: AppColors.lavenderDark.withValues(alpha: 0.55),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Container(
                            width: 18,
                            height: 24,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: [
                                const Color(0xFFE8DFF5),
                                const Color(0xFFFFF0E5),
                                const Color(0xFFEDE4F7),
                              ][index],
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.lavenderLight
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your bookshelf is waiting for its first story.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.lavenderDark,
              backgroundColor: AppColors.creamSurface,
              side: BorderSide(
                color: AppColors.lavenderLight.withValues(alpha: 0.7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Explore Stories',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
