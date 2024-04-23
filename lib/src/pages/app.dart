import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/app_bar.dart';
import '../controller/bottom_nav_controller .dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: GetBuilder<CustomAppBarController>(
        init: CustomAppBarController(),
        builder: (_) => Scaffold(
          appBar: CustomAppBar(),
          body: Container(),
          bottomNavigationBar: CustomBottomNavigationBar(),
        ),
      ),
    );
  }
}