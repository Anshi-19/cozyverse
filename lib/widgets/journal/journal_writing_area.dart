import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class JournalWritingArea extends StatelessWidget {
  const JournalWritingArea({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  static const placeholder =
      'What stayed with you after finishing this story?';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 180),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFBF7),
            Color(0xFFFFF5EE),
            Color(0xFFF8F2FC),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 18,
            left: 22,
            child: Icon(
              Icons.format_quote_rounded,
              size: 28,
              color: AppColors.lavender.withValues(alpha: 0.35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: TextField(
              controller: controller,
              maxLines: null,
              minLines: 6,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.65,
                    fontWeight: FontWeight.w500,
                  ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.75),
                      height: 1.65,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
