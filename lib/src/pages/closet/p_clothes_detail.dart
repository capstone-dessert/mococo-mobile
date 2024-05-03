import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_clothes.dart';
import '../../components/image_data.dart';
import '../../widgets/alert_modal.dart';
import '../../widgets/app_bar.dart';
import '../../clothes.dart';

class ClothesDetail extends StatefulWidget {
  const ClothesDetail({Key? key, required this.clothes}) : super(key: key);
  final Clothes clothes;

  @override
  _ClothesDetailState createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "상세 정보",
        buttonNum: 2,
        onBackButtonPressed: _onBackButtonPressed,
        onEditButtonPressed: () => _onEditButtonPressed(context),
        onDeleteButtonPressed: () => _onDeleteButtonPressed(context),
      ),
      body: Stack(
        children: [
          const SizedBox(
            height: 30,
          ),
          // 사진
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Index: ${widget.clothes.index}'), // 인덱스 값 출력
              SizedBox(
                height: 100,
                child: Image.asset(IconPath.topSample),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onEditButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditClothes(context: context),
      ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    AlertModal.show(context, false, 0);
  }


}