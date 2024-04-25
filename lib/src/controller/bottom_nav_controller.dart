import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum PageName { CLOSET, CODY_RECOMMND, CODY_RECORD }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void changeBottomNav(int value) {
    var page = PageName.values[value];
    switch(page){
      case PageName.CLOSET:
        break;
      case PageName.CODY_RECOMMND:
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
    navigatorKey.currentState!.pop();
  }
}