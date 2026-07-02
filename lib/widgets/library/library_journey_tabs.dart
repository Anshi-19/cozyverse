import 'package:flutter/material.dart';

import '../../models/story_tracker_item.dart';
import '../../theme/app_theme.dart';

class LibraryJourneyTabs extends StatelessWidget {
  const LibraryJourneyTabs({
    super.key,
    required this.selectedTab,
    required this.counts,
    required this.onSelected,
  });

  final StoryJourneyTab selectedTab;
  final Map<StoryJourneyTab, int> counts;
  final ValueChanged<StoryJourneyTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.creamSurface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        children: StoryJourneyTab.values.map((tab) {
          final isSelected = selectedTab == tab;
          final count = counts[tab] ?? 0;

          return Padding(
            padding: EdgeInsets.only(
              bottom: tab == StoryJourneyTab.completed ? 0 : 6,
            ),
            child: _JourneyTabButton(
              label: tab.label,
              count: count,
              isSelected: isSelected,
              onTap: () => onSelected(tab),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _JourneyTabButton extends StatelessWidget {
  const _JourneyTabButton({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOutCubic,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.lavenderLight.withValues(alpha: 0.5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: isSelected
            ? Border.all(
                color: AppColors.lavenderDark.withValues(alpha: 0.35),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Expanded(
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.creamSurface
                        : AppColors.lavenderLight.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$count',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.lavenderDark,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
