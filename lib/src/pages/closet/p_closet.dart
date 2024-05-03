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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: GridviewPage(
          onClothDetail: _onClothDetail,
          onLeftLogoAppBar: _onLeftLogoAppBar,
          isClothSelected: _isClothSelected,
          selectedClothIndices: _selectedClothIndices,
          toggleSelectableState: _toggleSelectableState,
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

