import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/image_list.dart';
import '../controller/bottom_nav_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: BaseAppBar(),
        body: GridviewPage(),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
