import '../models/journal_emotion.dart';

abstract final class JournalEmotionData {
  static const emotions = [
    JournalEmotion(id: 'happy', emoji: '😊', label: 'Happy'),
    JournalEmotion(id: 'emotional', emoji: '😭', label: 'Emotional'),
    JournalEmotion(id: 'inspired', emoji: '🤩', label: 'Inspired'),
    JournalEmotion(id: 'relaxed', emoji: '😌', label: 'Relaxed'),
    JournalEmotion(id: 'shocked', emoji: '😨', label: 'Shocked'),
    JournalEmotion(id: 'comforted', emoji: '💜', label: 'Comforted'),
    JournalEmotion(id: 'magical', emoji: '✨', label: 'Magical'),
  ];

  static JournalEmotion? findById(String id) {
    for (final emotion in emotions) {
      if (emotion.id == id) {
        return emotion;
      }
    }
    return null;
  }
}
