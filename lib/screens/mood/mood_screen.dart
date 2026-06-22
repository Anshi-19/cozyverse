import 'package:flutter/material.dart';

import '../../data/mood_data.dart';
import '../../data/mood_storage.dart';
import '../../models/mood.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _MoodBackground(),
          const DecorativeStars(),
          SafeArea(
            child: ListenableBuilder(
              listenable: MoodStorage.instance,
              builder: (context, _) {
                final selectedMood = MoodStorage.instance.selectedMood;

                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const _MoodHeader(),
                          const SizedBox(height: 24),
                          _MoodGrid(
                            moods: MoodData.moods,
                            selectedMoodId: selectedMood.id,
                            onMoodSelected: MoodStorage.instance.selectMood,
                          ),
                          const SizedBox(height: 20),
                          _SelectedMoodPreview(mood: selectedMood),
                        ]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodHeader extends StatelessWidget {
  const _MoodHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lavenderLight.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.lavenderDark,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Story Mood',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'How are you feeling today?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MoodGrid extends StatelessWidget {
  const _MoodGrid({
    required this.moods,
    required this.selectedMoodId,
    required this.onMoodSelected,
  });

  final List<Mood> moods;
  final String selectedMoodId;
  final ValueChanged<Mood> onMoodSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 520 ? 3 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.05,
          ),
          itemCount: moods.length,
          itemBuilder: (context, index) {
            final mood = moods[index];
            return _MoodOptionCard(
              mood: mood,
              isSelected: mood.id == selectedMoodId,
              onTap: () => onMoodSelected(mood),
            );
          },
        );
      },
    );
  }
}

class _MoodOptionCard extends StatelessWidget {
  const _MoodOptionCard({
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = MoodData.accentFor(mood);

    return AnimatedScale(
      scale: isSelected ? 1.04 : 1,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.lavenderDark
                    : AppColors.lavenderLight.withValues(alpha: 0.55),
                width: isSelected ? 2.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.lavender.withValues(alpha: 0.28)
                      : AppColors.lavender.withValues(alpha: 0.1),
                  blurRadius: isSelected ? 16 : 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mood.emoji,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 10),
                Text(
                  mood.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedMoodPreview extends StatelessWidget {
  const _SelectedMoodPreview({required this.mood});

  final Mood mood;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF3E8),
            Color(0xFFF5EEFB),
            Color(0xFFEDE4F7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.lavenderLight.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.lavender.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mood.emoji,
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mood.displayLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  mood.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.45,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodBackground extends StatelessWidget {
  const _MoodBackground();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.cream,
            Color(0xFFFFF5EC),
            Color(0xFFF8F2FC),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lavenderLight.withValues(alpha: 0.2),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.2,
            left: -50,
            child: Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFE8D6).withValues(alpha: 0.25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
