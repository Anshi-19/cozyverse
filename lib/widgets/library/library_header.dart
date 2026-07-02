import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({super.key});

  static const _illustrationPath = 'assets/illustrations/library_bookshelf.png';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
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
                      Icons.collections_bookmark_rounded,
                      color: AppColors.lavenderDark,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Library',
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.3,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Every story you\'ve collected lives here.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.35,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            _illustrationPath,
            width: 72,
            height: 72,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFF0E5),
                      Color(0xFFE8DFF5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.lavenderLight.withValues(alpha: 0.55),
                  ),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.lavenderDark.withValues(alpha: 0.65),
                  size: 32,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
