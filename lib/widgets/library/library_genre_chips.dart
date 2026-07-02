import 'package:flutter/material.dart';

import '../../data/library_presentation.dart';
import '../../models/library_story.dart';
import '../../theme/app_theme.dart';

class LibraryGenreChips extends StatelessWidget {
  const LibraryGenreChips({
    super.key,
    required this.story,
    this.maxChips = 2,
  });

  final LibraryStory story;
  final int maxChips;

  @override
  Widget build(BuildContext context) {
    final genres = LibraryPresentation.genresFor(story).take(maxChips);

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: genres
          .map(
            (genre) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: LibraryPresentation.chipColorFor(genre)
                    .withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                genre,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.lavenderDark,
                      fontSize: 10,
                    ),
              ),
            ),
          )
          .toList(),
    );
  }
}
