import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'cozy_card.dart';

class MoodCard extends StatelessWidget {
  const MoodCard({
    super.key,
    required this.moodLabel,
    required this.icon,
  });

  final String moodLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CozyCard(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF5EEFB),
          Color(0xFFEDE4F7),
          Color(0xFFFFF3E8),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Mood',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.lavenderLight.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    moodLabel,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lavenderLight.withValues(alpha: 0.45),
            ),
            child: Icon(
              icon,
              size: 32,
              color: AppColors.lavenderDark,
            ),
          ),
        ],
      ),
    );
  }
}
