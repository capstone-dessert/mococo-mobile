import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/controller/bottom_nav_controller.dart';
import '../components/image_data.dart';

class CustomBottomNavigationBar extends GetView<BottomNavController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 83,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.pageIndex.value,
        onTap: controller.changeBottomNav,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: [
          BottomNavigationBarItem(
              icon: SizedBox(height: 27, width: 27, child: Image.asset(IconPath.closetOff)),
              activeIcon: SizedBox(height:  27, width: 27, child: Image.asset(IconPath.closetOn)),
              label: '옷장'
          ),
          BottomNavigationBarItem(
              icon: SizedBox(height: 25.04, width: 24, child: Image.asset(IconPath.codiRecommendOff)),
              activeIcon: SizedBox(height: 25.04, width: 24, child: Image.asset(IconPath.codiRecommendOn)),
              label: '코디 추천'
          ),
          BottomNavigationBarItem(
              icon: SizedBox(height: 26, width: 27, child:Image.asset(IconPath.codiRecordOff)),
              activeIcon: SizedBox(height: 26, width: 27, child: Image.asset(IconPath.codiRecordOn)),
              label: '코디 기록'
          )
        ],
      ),
    );
  }
}
