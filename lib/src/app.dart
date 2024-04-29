import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/pages/closet/p_closet.dart';
import 'package:mococo_mobile/src/pages/codi_recommend/p_codi_recommend.dart';
import 'package:mococo_mobile/src/widgets/bottom_navigation_bar.dart';
import 'controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () => controller.pop(),
      child: Obx(
        () => Scaffold(
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
              const Center(child: Text('CODY_RECORD')),
            ],
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      )
    );
  }
}
