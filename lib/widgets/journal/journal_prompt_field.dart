import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class JournalPromptField extends StatelessWidget {
  const JournalPromptField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.minLines = 2,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.creamSurface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.lavenderLight.withValues(alpha: 0.5),
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: null,
            minLines: minLines,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
