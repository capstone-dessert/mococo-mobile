import 'package:get/get.dart';
import 'package:mococo_mobile/src/controller/bottom_nav_controller.dart';

import '../widgets/app_bar.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(BaseAppBarController(), permanent: true);
  }
}