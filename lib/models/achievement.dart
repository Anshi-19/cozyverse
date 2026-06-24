class Achievement {
  const Achievement({
    required this.id,
    required this.title,
    required this.emoji,
    required this.isUnlocked,
  });

  final String id;
  final String title;
  final String emoji;
  final bool isUnlocked;
}
