import 'package:flutter/material.dart';

import '../../models/library_filter.dart';
import '../../theme/app_theme.dart';

class LibraryFilterChips extends StatelessWidget {
  const LibraryFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onSelected,
  });

  final LibraryFilter selectedFilter;
  final ValueChanged<LibraryFilter> onSelected;

  static const filters = LibraryFilter.values;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;

          return Padding(
            padding: EdgeInsets.only(
              right: filter == filters.last ? 0 : 8,
            ),
            child: _FilterChip(
              label: filter.label,
              isSelected: isSelected,
              onTap: () => onSelected(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _backgroundColor {
    if (!isSelected) {
      return AppColors.creamSurface;
    }

    return switch (label) {
      'Books' => const Color(0xFFE8DFF5),
      'Movies' => const Color(0xFFFFF0E5),
      'Series' => const Color(0xFFEDE4F7),
      'Completed' => const Color(0xFFD8EDDF),
      'Currently Enjoying' => const Color(0xFFF5EEFB),
      'Wishlist' => const Color(0xFFFFF5EC),
      _ => AppColors.lavenderLight.withValues(alpha: 0.45),
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.03 : 1,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOutCubic,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? AppColors.lavenderDark
                : AppColors.lavenderLight.withValues(alpha: 0.55),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected
                          ? AppColors.lavenderDark
                          : AppColors.textPrimary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
