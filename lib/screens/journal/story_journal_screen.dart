import 'package:flutter/material.dart';

import '../../data/journal_storage.dart';
import '../../models/recommendation.dart';
import '../../models/story_journal_entry.dart';
import '../../theme/app_theme.dart';
import '../../widgets/decorative_stars.dart';
import '../../widgets/journal/journal_date_display.dart';
import '../../widgets/journal/journal_emotion_selector.dart';
import '../../widgets/journal/journal_header.dart';
import '../../widgets/journal/journal_prompt_field.dart';
import '../../widgets/journal/journal_save_button.dart';
import '../../widgets/journal/journal_section_label.dart';
import '../../widgets/journal/journal_star_rating.dart';
import '../../widgets/journal/journal_story_card.dart';
import '../../widgets/journal/journal_writing_area.dart';

class StoryJournalScreen extends StatefulWidget {
  const StoryJournalScreen({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  State<StoryJournalScreen> createState() => _StoryJournalScreenState();
}

class _StoryJournalScreenState extends State<StoryJournalScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  late final TextEditingController _reflectionsController;
  late final TextEditingController _favoriteMomentController;
  late final TextEditingController _favoriteQuoteController;

  String? _selectedEmotionId;
  int _starRating = 0;
  final DateTime _today = DateTime.now();

  static const _horizontalPadding = 24.0;
  static const _sectionGap = 28.0;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();

    _reflectionsController = TextEditingController();
    _favoriteMomentController = TextEditingController();
    _favoriteQuoteController = TextEditingController();

    _loadExistingEntry();
  }

  void _loadExistingEntry() {
    final existing = JournalStorage.instance.entryForStory(
      widget.recommendation.title,
    );
    if (existing == null) {
      return;
    }

    _reflectionsController.text = existing.reflections;
    _favoriteMomentController.text = existing.favoriteMoment;
    _favoriteQuoteController.text = existing.favoriteQuote;
    _selectedEmotionId = existing.emotionId;
    _starRating = existing.starRating;
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _reflectionsController.dispose();
    _favoriteMomentController.dispose();
    _favoriteQuoteController.dispose();
    super.dispose();
  }

  void _saveJournal() {
    if (_selectedEmotionId == null || _starRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please select an emotion and star rating before saving.',
          ),
          backgroundColor: AppColors.lavenderDark,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    JournalStorage.instance.save(
      StoryJournalEntry(
        storyTitle: widget.recommendation.title,
        reflections: _reflectionsController.text.trim(),
        emotionId: _selectedEmotionId!,
        starRating: _starRating,
        favoriteMoment: _favoriteMomentController.text.trim(),
        favoriteQuote: _favoriteQuoteController.text.trim(),
        savedAt: DateTime.now(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Journal saved'),
        backgroundColor: AppColors.lavenderDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        children: [
          const _JournalBackground(),
          const DecorativeStars(),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      _horizontalPadding,
                      8,
                      _horizontalPadding,
                      28 + bottomPadding,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.creamSurface.withValues(alpha: 0.92),
                              radius: 20,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  size: 20,
                                ),
                                color: AppColors.lavenderDark,
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const JournalHeader(),
                        const SizedBox(height: 28),
                        JournalStoryCard(
                          recommendation: widget.recommendation,
                        ),
                        const SizedBox(height: _sectionGap),
                        const JournalSectionLabel(
                          title: 'Your Reflection',
                          subtitle: 'Take your time — there are no wrong answers.',
                        ),
                        const SizedBox(height: 14),
                        JournalWritingArea(
                          controller: _reflectionsController,
                        ),
                        const SizedBox(height: _sectionGap),
                        const JournalSectionLabel(
                          title: 'How did it make you feel?',
                        ),
                        const SizedBox(height: 14),
                        JournalEmotionSelector(
                          selectedEmotionId: _selectedEmotionId,
                          onSelected: (emotion) {
                            setState(() => _selectedEmotionId = emotion.id);
                          },
                        ),
                        const SizedBox(height: _sectionGap),
                        const JournalSectionLabel(
                          title: 'Your Rating',
                          subtitle: 'How would you rate this story?',
                        ),
                        const SizedBox(height: 14),
                        JournalStarRating(
                          rating: _starRating,
                          onRatingChanged: (rating) {
                            setState(() => _starRating = rating);
                          },
                        ),
                        const SizedBox(height: _sectionGap),
                        JournalPromptField(
                          label: 'Favorite Moment',
                          hint: 'What scene or moment will you always remember?',
                          controller: _favoriteMomentController,
                        ),
                        const SizedBox(height: _sectionGap),
                        JournalPromptField(
                          label: 'Favorite Quote',
                          hint: 'Write a quote you loved.',
                          controller: _favoriteQuoteController,
                        ),
                        const SizedBox(height: _sectionGap),
                        const JournalSectionLabel(title: 'Date'),
                        const SizedBox(height: 12),
                        JournalDateDisplay(date: _today),
                        const SizedBox(height: 32),
                        JournalSaveButton(onPressed: _saveJournal),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _JournalBackground extends StatelessWidget {
  const _JournalBackground();

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
