import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum PageName { closet, codiRecommend, codiRecord }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> navigatorKey1 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey3 = GlobalKey<NavigatorState>();

  void changeBottomNav(int value) {
    var page = PageName.values[value];
    switch(page){
      case PageName.closet:
        break;
      case PageName.codiRecommend:
        break;
      case PageName.codiRecord:
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