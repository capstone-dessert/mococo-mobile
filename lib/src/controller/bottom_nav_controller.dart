import 'package:flutter/material.dart';
import '../widgets/image_data.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: const Color(0xff999999),
      selectedLabelStyle: const TextStyle(fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(width: 27, height: 27, child: Image.asset(IconPath.closetOff)),
          activeIcon: SizedBox(width: 27, height: 27, child: Image.asset(IconPath.closetOn)),
          label: '옷장',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(width: 24, height: 25.04, child: Image.asset(IconPath.codiRecommendOff)),
          activeIcon: SizedBox(width: 24, height: 25.04, child: Image.asset(IconPath.codiRecommendOn)),
          label: '코디 추천',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(width: 27, height: 26, child: Image.asset(IconPath.codiRecordOff)),
          activeIcon: SizedBox(width: 27, height: 26, child: Image.asset(IconPath.codiRecordOn)),
          label: '코디 기록',
        ),
      ],
    );
  }
}
