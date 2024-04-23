import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/app_bar.dart';
import '../controller/bottom_nav_controller .dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CustomAppBarController>().toggleAddButtonVisibility();

    return Scaffold(
      appBar: CustomAppBar(showAddButton: false),
      body: Container(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
