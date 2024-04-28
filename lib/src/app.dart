import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/pages/p_closet.dart';
import 'package:mococo_mobile/src/pages/p_codi_recommend.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () => controller.pop(),
      child: Obx(
        () => Scaffold(
          appBar: AppBar(toolbarHeight: 35,),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              const Closet(),
              // 탭바 유지한 채 페이지 이동
              Navigator(
                key: controller.navigatorKey,
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(builder: (context) => const CodiRecommend());
                },
              ) ,
              Container(child: const Center(child: Text('CODY_RECORD')),),
            ],
          ),
          bottomNavigationBar: SizedBox(
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
          ),
        ),
      )
    );
  }
}
