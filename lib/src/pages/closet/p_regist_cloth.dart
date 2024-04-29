import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_bar.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<BaseAppBarController>().toggleAddButtonVisibility();

    return Scaffold(
      appBar: const BaseAppBar(showAddButton: false),
      body: Container(),
    );
  }
}
