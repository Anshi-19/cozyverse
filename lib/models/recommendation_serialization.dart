import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/recommendation.dart';

extension RecommendationSerialization on Recommendation {
  String get favoriteId => '$moodId|$title|$category';

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'moodId': moodId,
      'description': description,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'iconFontPackage': icon.fontPackage,
    };
  }

  static Recommendation fromJson(Map<String, dynamic> json) {
    return Recommendation(
      title: json['title'] as String,
      category: json['category'] as String,
      moodId: json['moodId'] as String,
      description: json['description'] as String,
      icon: IconData(
        json['iconCodePoint'] as int,
        fontFamily: json['iconFontFamily'] as String?,
        fontPackage: json['iconFontPackage'] as String?,
      ),
    );
  }

  static List<Recommendation> decodeList(String? raw) {
    if (raw == null || raw.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  static String encodeList(List<Recommendation> recommendations) {
    return jsonEncode(recommendations.map((item) => item.toJson()).toList());
  }
}
