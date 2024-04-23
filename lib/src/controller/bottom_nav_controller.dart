import 'package:flutter/material.dart';
import '../widgets/image_data.dart';

class CustomBottomNavigationBar extends StatelessWidget {
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
        BottomNavigationBarItem(
          icon: Image.asset(IconPath.codiRecommendOff, width: 55, height: 55),
          activeIcon:
              Image.asset(IconPath.codiRecommendOn, width: 55, height: 55),
          label: 'codiRecommend',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(IconPath.codiRecordOff, width: 55, height: 55),
          activeIcon: Image.asset(IconPath.codiRecordOn, width: 55, height: 55),
          label: 'codiRecord',
        ),
      ],
    );
  }
}
