import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/pages/closet/p_search.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/image_list.dart';
import 'p_regist_cloth.dart';

class Closet extends StatelessWidget {
  const Closet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeftLogoAppBar(onAddButtonPressed: _onAddButtonPressed),
      body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: const GridviewPage()),
    );
  }

  void _onAddButtonPressed() {
    // Get.to(() => AddPage());
    Get.to(() => SearchClothes());
  }
}
