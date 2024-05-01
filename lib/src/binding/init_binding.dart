import 'package:get/get.dart';
import 'package:mococo_mobile/src/controller/bottom_nav_controller.dart';
import 'package:mococo_mobile/src/controller/app_bar.dart';

// import '../widgets/app_bar.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(BaseAppBar2(), permanent: true);
  }
}