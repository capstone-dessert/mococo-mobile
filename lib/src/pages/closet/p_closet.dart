import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/pages/p_search.dart';
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
        padding: const EdgeInsets.only(left: 10, right: 10), //원래 16,16
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 5,
              left: 6,
              child: Row(
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('전체'),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      _onSearchButtonPressed();
                    },
                    child: Text('검색'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 55, left: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0개'),
                ],
              ),
            ),
            Positioned(
                top: 40,
                right: 0,
                child: TextButton(
                  child: Text(
                    '선택',
                    style: TextStyle(color: Colors.black87),
                  ),
                  onPressed: () {},
                )),
            Padding(
              padding: EdgeInsets.only(top: 90, right: 6, left: 6),
              child: const GridviewPage(),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddButtonPressed() {
    Get.to(AddPage());
  }

  void _onSearchButtonPressed() {
    Get.to(SearchPage());
  }
}
