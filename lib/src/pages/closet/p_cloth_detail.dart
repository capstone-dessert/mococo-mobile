import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_cloth.dart';
import '../../components/image_data.dart';
import '../../widgets/alert_modal.dart';
import '../../widgets/app_bar.dart';
import '../../cloth.dart';
import 'p_regist_cloth.dart';

class ClothDetail extends StatefulWidget {
  const ClothDetail({Key? key, required this.cloth}) : super(key: key);
  final Cloth cloth;

  @override
  _ClothDetailState createState() => _ClothDetailState();
}

class _ClothDetailState extends State<ClothDetail> {
  void _onEditButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCloth(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "상세 정보",
        buttonNum: 2,
        onDeleteButtonPressed: _onDeleteButtonPressed,
        onEditButtonPressed: _onEditButtonPressed,
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
              Text('Index: ${widget.cloth.index}'), // 인덱스 값 출력
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

  void _onDeleteButtonPressed() {
    AlertModal.show(context);
  }
}

