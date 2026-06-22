import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/library_story.dart';

extension LibraryStorySerialization on LibraryStory {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'rating': rating,
      'progress': progress,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'iconFontPackage': icon.fontPackage,
      'gradientColors': gradientColors.map((color) => color.toARGB32()).toList(),
      'type': type.name,
    };
  }

  static LibraryStory fromJson(Map<String, dynamic> json) {
    return LibraryStory(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      rating: (json['rating'] as num).toDouble(),
      progress: (json['progress'] as num).toDouble(),
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: json['iconFontFamily'] as String?,
        fontPackage: json['iconFontPackage'] as String?,
      ),
      gradientColors: (json['gradientColors'] as List<dynamic>)
          .map((value) => Color(value as int))
          .toList(),
      type: LibraryStoryType.values.byName(json['type'] as String),
    );
  }

  static List<LibraryStory> decodeList(String? raw) {
    if (raw == null || raw.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  static String encodeList(List<LibraryStory> stories) {
    return jsonEncode(stories.map((story) => story.toJson()).toList());
  }
}
