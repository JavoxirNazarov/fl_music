import 'package:flutter/material.dart';
import 'package:top_music/resources/icons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(AppIcons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.myMusic),
          label: 'Music',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.search),
          label: 'Research',
        ),
      ],
    );
  }
}
