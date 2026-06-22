import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DeleteStoryDialog {
  DeleteStoryDialog._();

  static Future<bool> show(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.creamSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.lavenderLight.withValues(alpha: 0.45),
          ),
        ),
        title: Text(
          'Delete Story?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
        ),
        content: Text(
          'Are you sure you want to remove this story from your library?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC96B6B),
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    return confirmed ?? false;
  }
}
