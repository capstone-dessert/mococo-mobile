import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/add.dart';
import '../components/image_data.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showAddButton;

  CustomAppBar({this.showAddButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 105,
      leadingWidth: 500,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(IconPath.topLogo, width: 170,),
                if (showAddButton)
                  GestureDetector(
                    onTap: () {
                      // 추가 아이콘 클릭 시 동작
                      Get.to(AddPage()); // Add 페이지로 이동
                    },
                    child: Image.asset(IconPath.add, width: 30,), // add 이미지
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(105); // AppBar의 높이 지정
}

class CustomAppBarController extends GetxController {
  RxBool showAddButton = true.obs;

  void toggleAddButtonVisibility() {
    showAddButton.value = !showAddButton.value;
  }
}
