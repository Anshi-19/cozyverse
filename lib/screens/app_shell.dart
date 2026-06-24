import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'library/library_screen.dart';
import 'mood/mood_screen.dart';
import 'profile/profile_screen.dart';
import 'saved/saved_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.auto_awesome_outlined),
      selectedIcon: Icon(Icons.auto_awesome_rounded),
      label: 'Mood',
    ),
    NavigationDestination(
      icon: Icon(Icons.collections_bookmark_outlined),
      selectedIcon: Icon(Icons.collections_bookmark_rounded),
      label: 'Library',
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_outline_rounded),
      selectedIcon: Icon(Icons.favorite_rounded),
      label: 'Saved',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Profile',
    ),
  ];

  static const _profileTabIndex = 4;

  Widget _buildTab(int index, Widget child) {
    final isSelected = _selectedIndex == index;

    return IgnorePointer(
      ignoring: !isSelected,
      child: AnimatedOpacity(
        opacity: isSelected ? 1 : 0,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildTab(0, const HomeScreen()),
          _buildTab(1, const MoodScreen()),
          _buildTab(2, const LibraryScreen()),
          _buildTab(3, const SavedScreen()),
          _buildTab(
            4,
            ProfileScreen(isActive: _selectedIndex == _profileTabIndex),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: _destinations,
      ),
    );
  }
}
