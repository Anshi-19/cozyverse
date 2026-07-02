import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LibrarySearchField extends StatelessWidget {
  const LibrarySearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      readOnly: onChanged == null,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textPrimary,
          ),
      decoration: InputDecoration(
        hintText: 'Search your story journey...',
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
        filled: true,
        fillColor: AppColors.cream,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.lavenderDark,
        ),
        suffixIcon: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            if (controller.text.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              icon: Icon(
                Icons.close_rounded,
                color: AppColors.textSecondary.withValues(alpha: 0.8),
              ),
              onPressed: () {
                controller.clear();
                onChanged?.call('');
              },
            );
          },
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.lavenderLight.withValues(alpha: 0.6),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.lavenderLight.withValues(alpha: 0.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.lavenderDark,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
