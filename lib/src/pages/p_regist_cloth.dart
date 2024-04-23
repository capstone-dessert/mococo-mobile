import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_controller .dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<BaseAppBarController>().toggleAddButtonVisibility();

    return Scaffold(
      appBar: BaseAppBar(showAddButton: false),
      body: Container(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
