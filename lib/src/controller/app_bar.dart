import 'package:flutter/material.dart';
import '../components/modal_action_sheet.dart';
import '../components/image_data.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {

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
                GestureDetector(
                  onTap: () {
                    // add 버튼을 탭하면 액션 시트를 표시합니다.
                    ActionSheet.show(context); // ActionSheet의 show 함수를 호출합니다.
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
  Size get preferredSize => Size.fromHeight(105);
}