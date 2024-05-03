import 'package:flutter/material.dart';
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
  int itemCount = 9;

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
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Stack(
          children: <Widget>[
            if (!_isClothSelected)
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
                        side: BorderSide(color: Colors.purpleAccent, width: 3.0),
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
              padding:
              EdgeInsets.only(top: _isClothSelected ? 0 : 58, left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_isClothSelected ? '${_selectedClothIndices.length}개' : '$itemCount개',),
                ],
              ),
            ),
            Positioned(
              top: 40,
              right: 0,
              child: _isClothSelected ? SizedBox() : TextButton(
                child: Text(
                  '선택',
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: _isClothSelected ? 24 : 90, right: 6, left: 6),
              child: GridviewPage(
                onClothDetail: _onClothDetail,
                onLeftLogoAppBar: _onLeftLogoAppBar,
                isClothSelected: _isClothSelected,
                selectedClothIndices: _selectedClothIndices,
                toggleSelectableState: _toggleSelectableState,
                itemCount: itemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    setState(() {
      _isClothSelected = false;
      _selectedClothIndices.clear();
    });
  }

  void _onAddButtonPressed(BuildContext context) {
    GetImageModal.show(context);
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
    if(_selectedClothIndices.length > 0)
      AlertModal.show(context, true, _selectedClothIndices.length);
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