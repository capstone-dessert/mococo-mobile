import 'package:flutter/material.dart';
import 'package:mococo_mobile/src//components/image_data.dart';

class SearchBottomNavBar extends StatelessWidget {
  const SearchBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              IconPath.closetOff,
              width: 55,
              height: 55,
            ),
            activeIcon: Image.asset(IconPath.closetOn, width: 55, height: 55),
            label: 'closet',
          ),
        ]
    );
  }
}