import 'package:flutter/material.dart';

import '../../models/library_story.dart';
import '../../theme/app_theme.dart';

class StoryActionsSheet extends StatelessWidget {
  const StoryActionsSheet({
    super.key,
    required this.story,
    required this.onEdit,
    required this.onDelete,
  });

  final LibraryStory story;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  static Future<void> show(
    BuildContext context, {
    required LibraryStory story,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.creamSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StoryActionsSheet(
        story: story,
        onEdit: onEdit,
        onDelete: onDelete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lavenderLight,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            story.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(
              Icons.edit_rounded,
              color: AppColors.lavenderDark,
            ),
            title: const Text(
              'Edit Story',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onTap: () {
              Navigator.of(context).pop();
              onEdit();
            },
          ),
          const SizedBox(height: 4),
          ListTile(
            leading: const Icon(
              Icons.delete_outline_rounded,
              color: Color(0xFFC96B6B),
            ),
            title: const Text(
              'Delete Story',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFFC96B6B),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            onTap: () {
              Navigator.of(context).pop();
              onDelete();
            },
          ),
        ],
      ),
    );
  }
}
