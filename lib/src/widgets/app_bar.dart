import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/p_regist_cloth.dart';
import 'image_data.dart';

//기본 앱바
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showAddButton;

  const BaseAppBar({super.key, this.showAddButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 105,
      leadingWidth: 500,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19, right: 16, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  IconPath.topLogo,
                  width: 140,
                ),
                if (showAddButton)
                  GestureDetector(
                    onTap: () {
                      // 추가 아이콘 클릭 시 동작
                      Get.to(AddPage()); // Add 페이지로 이동
                    },
                    child: SizedBox(width: 30, height: 30,
                      child: Image.asset(
                        IconPath.add,
                      ),
                    ), // add 이미지
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(105); // AppBar의 높이 지정
}

class BaseAppBarController extends GetxController {
  RxBool showAddButton = true.obs;

  void toggleAddButtonVisibility() {
    showAddButton.value = !showAddButton.value;
  }
}

//양쪽 버튼, 가운데 글씨 앱바
class TwoSelectAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TwoSelectAppBar({super.key});

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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      print("뒤로가기버튼클릭");
                    },
                    icon: Image.asset(
                      IconPath.goBack,
                      width: 24,
                    )),
                const Text(
                  "의류 등록",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text(
                    "등록",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(105);
}
