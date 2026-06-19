import 'package:flutter/material.dart';

import '../../data/library_catalog.dart';
import '../../models/library_story.dart';
import '../../models/library_story_options.dart';
import '../../theme/app_theme.dart';

class AddStorySheet extends StatefulWidget {
  const AddStorySheet({
    super.key,
    required this.onSave,
  });

  final ValueChanged<LibraryStory> onSave;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<LibraryStory> onSave,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.creamSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => AddStorySheet(onSave: onSave),
    );
  }

  @override
  State<AddStorySheet> createState() => _AddStorySheetState();
}

class _AddStorySheetState extends State<AddStorySheet> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LibraryStoryType _type = LibraryStoryType.book;
  late String _status = LibraryStoryStatuses.forType(_type).first;
  double _rating = 3;
  double _progress = 0;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  List<String> get _statusOptions => LibraryStoryStatuses.forType(_type);

  void _onTypeChanged(LibraryStoryType type) {
    setState(() {
      _type = type;
      _status = _statusOptions.first;
    });
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final defaults = LibraryStoryDefaults.forType(_type);
    final story = LibraryStory(
      id: LibraryCatalog.nextId(_type),
      title: _titleController.text.trim(),
      status: _status,
      rating: _rating,
      progress: _progress / 100,
      icon: defaults.icon,
      gradientColors: defaults.gradientColors,
      type: _type,
    );

    widget.onSave(story);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 24 + bottomInset),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.lavenderLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Add Story',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Add a new book, movie, or series to your library.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                'Story Type',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 10),
              SegmentedButton<LibraryStoryType>(
                segments: const [
                  ButtonSegment(
                    value: LibraryStoryType.book,
                    label: Text('Book'),
                    icon: Icon(Icons.menu_book_rounded, size: 18),
                  ),
                  ButtonSegment(
                    value: LibraryStoryType.movie,
                    label: Text('Movie'),
                    icon: Icon(Icons.movie_rounded, size: 18),
                  ),
                  ButtonSegment(
                    value: LibraryStoryType.series,
                    label: Text('Series'),
                    icon: Icon(Icons.live_tv_rounded, size: 18),
                  ),
                ],
                selected: {_type},
                onSelectionChanged: (selection) {
                  _onTypeChanged(selection.first);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  filled: true,
                  fillColor: AppColors.cream,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppColors.lavenderLight.withValues(alpha: 0.6),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppColors.lavenderLight.withValues(alpha: 0.6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.lavenderDark),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownMenu<String>(
                key: ValueKey(_type),
                initialSelection: _status,
                label: const Text('Status'),
                expandedInsets: EdgeInsets.zero,
                dropdownMenuEntries: _statusOptions
                    .map(
                      (status) => DropdownMenuEntry(
                        value: status,
                        label: status,
                      ),
                    )
                    .toList(),
                onSelected: (value) {
                  if (value != null) {
                    setState(() => _status = value);
                  }
                },
              ),
              const SizedBox(height: 20),
              _SliderField(
                label: 'Rating',
                valueLabel: _rating.toStringAsFixed(0),
                value: _rating,
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (value) => setState(() => _rating = value),
              ),
              const SizedBox(height: 16),
              _SliderField(
                label: 'Progress',
                valueLabel: '${_progress.round()}%',
                value: _progress,
                min: 0,
                max: 100,
                divisions: 20,
                onChanged: (value) => setState(() => _progress = value),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.lavenderDark,
                        side: BorderSide(
                          color: AppColors.lavenderLight.withValues(alpha: 0.8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.lavenderDark,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderField extends StatelessWidget {
  const _SliderField({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            Text(
              valueLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.lavenderDark,
                  ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: valueLabel,
          activeColor: AppColors.lavenderDark,
          inactiveColor: AppColors.lavenderLight.withValues(alpha: 0.45),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
