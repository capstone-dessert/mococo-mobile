import 'package:flutter/material.dart';
import '../../cloth.dart';
import '../../widgets/get_image_modal.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/image_list.dart';
import '../../components/image_data.dart';
import 'p_cloth_detail.dart';
import 'p_regist_cloth.dart';

class Closet extends StatelessWidget {
  const Closet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeftLogoAppBar(onAddButtonPressed: _onAddButtonPressed),
      body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
        child: GridviewPage(onClothSelected: _onClothSelected),
      )
    );
  }

  void _onAddButtonPressed(BuildContext context) {
    GetImageModal.show(context);
  }

  void _onClothSelected(BuildContext context, Cloth cloth) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClothDetail(cloth: cloth),
      ),
    );
  }
}