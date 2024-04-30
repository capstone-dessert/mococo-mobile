import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/bottom_nav_controller.dart';
import 'package:mococo_mobile/src/widgets/image_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: BaseAppBar(),
        body: Container(padding: EdgeInsets.only(left: 16, right: 16, bottom: 0), child: GridviewPage()),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
