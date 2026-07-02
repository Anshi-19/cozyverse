import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.name = 'Anshi',
    this.subtitle = 'Story Explorer ✨',
    this.description = 'Building a universe of stories.',
  });

  final String name;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileAvatar(name: name),
        const SizedBox(height: 20),
        Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.lavenderDark,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
                fontStyle: FontStyle.italic,
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
      width: 112,
      height: 112,
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
            top: 16,
            right: 20,
            child: Icon(
              Icons.star_rounded,
              size: 14,
              color: AppColors.lavenderDark.withValues(alpha: 0.45),
            ),
          ),
          Positioned(
            bottom: 18,
            left: 18,
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
                  fontSize: 40,
                ),
          ),
        ],
      ),
    );
  }
}
