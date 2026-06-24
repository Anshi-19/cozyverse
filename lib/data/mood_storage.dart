import 'package:flutter/foundation.dart';

import '../models/mood.dart';
import 'mood_data.dart';

class MoodStorage extends ChangeNotifier {
  MoodStorage._();

  static final MoodStorage instance = MoodStorage._();

  Mood _selectedMood = MoodData.defaultMood;
  final Set<String> _exploredMoodIds = {MoodData.defaultMoodId};

  Mood get selectedMood => _selectedMood;

  int get exploredMoodCount => _exploredMoodIds.length;

  void selectMood(Mood mood) {
    _exploredMoodIds.add(mood.id);

    if (_selectedMood.id == mood.id) {
      return;
    }

    _selectedMood = mood;
    notifyListeners();
  }
}
