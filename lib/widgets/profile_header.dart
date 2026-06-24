import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.name = 'Anshi',
    this.subtitle = 'Building a universe of stories ✨',
  });

  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileAvatar(name: name),
        const SizedBox(height: 16),
        Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE8DFF5),
            Color(0xFFD4C5E8),
            Color(0xFFFFF0E5),
          ],
        ),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.7),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 14,
            right: 18,
            child: Icon(
              Icons.star_rounded,
              size: 14,
              color: AppColors.lavenderDark.withValues(alpha: 0.45),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Icon(
              Icons.auto_awesome,
              size: 12,
              color: AppColors.lavenderDark.withValues(alpha: 0.35),
            ),
          ),
          Text(
            initial,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.lavenderDark,
                ),
          ),
        ],
      ),
    );
  }
}
