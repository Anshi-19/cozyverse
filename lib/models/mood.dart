class Mood {
  const Mood({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
  });

  final String id;
  final String name;
  final String emoji;
  final String description;

  String get displayLabel => '$emoji $name';
}
