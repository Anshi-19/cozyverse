import 'package:flutter/material.dart';

import '../../data/library_presentation.dart';
import '../../models/library_story.dart';
import '../../theme/app_theme.dart';

class LibraryStoryCover extends StatelessWidget {
  const LibraryStoryCover({
    super.key,
    required this.story,
    required this.borderRadius,
  });

  final LibraryStory story;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final assetPath = LibraryPresentation.coverAssetPath(story);

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            assetPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: story.gradientColors,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.38),
                    ),
                    child: Icon(
                      story.icon,
                      size: 36,
                      color: AppColors.lavenderDark,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.textPrimary.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
