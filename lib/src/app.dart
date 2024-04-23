import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/app_bar.dart';
import 'controller/bottom_nav_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: BaseAppBar(),
        body: Container(),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}