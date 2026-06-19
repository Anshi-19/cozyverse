import 'package:flutter/material.dart';

import 'screens/onboarding/onboarding_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CozyVerseApp());
}

class CozyVerseApp extends StatelessWidget {
  const CozyVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CozyVerse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const OnboardingScreen(),
    );
  }
}
