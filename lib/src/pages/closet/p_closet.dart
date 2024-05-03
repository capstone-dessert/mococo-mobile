import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mococo_mobile/src/pages/closet/p_regist_cloth.dart';
import 'package:mococo_mobile/src/widgets/alert_modal.dart';
import '../../cloth.dart';
import '../../widgets/get_image_modal.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/image_list.dart';
import 'p_cloth_detail.dart';

class Closet extends StatefulWidget {
  const Closet({Key? key});

  @override
  _ClosetState createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {
  bool _isClothSelected = false;
  List<int> _selectedClothIndices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isClothSelected
          ? TextTitleAppBar(
        title: "의류 선택",
        buttonNum: 1,
        onBackButtonPressed: _onBackButtonPressed,
        onDeleteButtonPressed: () {
          _onDeleteButtonPressed(context);
        },
      )
          : LeftLogoAppBar(onAddButtonPressed: _onAddButtonPressed),
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
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        side: BorderSide(
                          color: Colors.purpleAccent,
                          width: 3.0,
                        )
                    ),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      print("검색버튼누름");
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
              child: GridviewPage(
                onClothDetail: _onClothDetail,
                onLeftLogoAppBar: _onLeftLogoAppBar,
                isClothSelected: _isClothSelected,
                selectedClothIndices: _selectedClothIndices,
                toggleSelectableState: _toggleSelectableState,),
            ),
          ],
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    setState(() {
      _isClothSelected = false;
      _selectedClothIndices.clear(); // 선택된 의류 인덱스 초기화
    });
  }

  void _onAddButtonPressed(BuildContext context) {
    GetImageModal.show(context);
    // Get.to(AddPage()); // 의류 등록 페이지
  }

  void _onClothDetail(BuildContext context, Cloth cloth) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClothDetail(cloth: cloth),
      ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    AlertModal.show(context);
  }

  void _onLeftLogoAppBar(bool isLeftLogoAppBar) {
    setState(() {
      _isClothSelected = !isLeftLogoAppBar;
    });
  }

  void _toggleSelectableState() {
    setState(() {
      _isClothSelected = true;
    });
  }
}
