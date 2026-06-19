import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  Color get _backgroundColor {
    return switch (status) {
      'Reading' || 'Watching' => AppColors.lavenderLight.withValues(alpha: 0.55),
      'Completed' || 'Watched' => const Color(0xFFD8EDDF),
      _ => const Color(0xFFFFF0E5),
    };
  }

  Color get _textColor {
    return switch (status) {
      'Reading' || 'Watching' => AppColors.lavenderDark,
      'Completed' || 'Watched' => const Color(0xFF4A7A5A),
      _ => const Color(0xFF9A7B6A),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _textColor.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _textColor,
        ),
      ),
    );
  }
}
