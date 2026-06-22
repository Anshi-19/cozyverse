import 'package:flutter/foundation.dart';

import '../models/mood.dart';
import 'mood_data.dart';

class MoodStorage extends ChangeNotifier {
  MoodStorage._();

  static final MoodStorage instance = MoodStorage._();

  Mood _selectedMood = MoodData.defaultMood;

  Mood get selectedMood => _selectedMood;

  void selectMood(Mood mood) {
    if (_selectedMood.id == mood.id) {
      return;
    }

    _selectedMood = mood;
    notifyListeners();
  }
}
