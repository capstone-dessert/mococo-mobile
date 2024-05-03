import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum PageName { CLOSET, CODY_RECOMMNED, CODY_RECORD }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> navigatorKey1 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey3 = GlobalKey<NavigatorState>();

  void changeBottomNav(int value) {
    var page = PageName.values[value];
    switch(page){
      case PageName.CLOSET:
        break;
      case PageName.CODY_RECOMMNED:
        break;
      case PageName.CODY_RECORD:
        break;
    }
    _changePage(value);
  }

  void _changePage(int value) {
    pageIndex(value);
  }

  void pop() {
    navigatorKey1.currentState!.pop();
    navigatorKey2.currentState!.pop();
    navigatorKey3.currentState!.pop();
  }
}