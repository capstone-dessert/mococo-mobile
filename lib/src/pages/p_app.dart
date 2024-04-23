import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/widgets/image_list.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_controller .dart';

// void main() {
//   runApp(const App());
// }

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => {if (false) {}},
      child: GetBuilder<BaseAppBarController>(
        init: BaseAppBarController(),
        builder: (_) => Scaffold(
          appBar: TwoSelectAppBar(),
          body: Container(),
          bottomNavigationBar: CustomBottomNavigationBar(),
        ),
      ),
    ));
  }
}
