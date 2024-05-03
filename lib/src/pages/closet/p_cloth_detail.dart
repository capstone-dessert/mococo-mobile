import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_cloth.dart';
import '../../components/image_data.dart';
import '../../widgets/alert_modal.dart';
import '../../widgets/app_bar.dart';
import '../../cloth.dart';

class ClothDetail extends StatefulWidget {
  const ClothDetail({Key? key, required this.cloth}) : super(key: key);
  final Cloth cloth;

  @override
  _ClothDetailState createState() => _ClothDetailState();
}

class _ClothDetailState extends State<ClothDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "상세 정보",
        buttonNum: 2,
        onBackButtonPressed: _onBackButtonPressed,
        onEditButtonPressed: () => _onEditButtonPressed(context),
        onDeleteButtonPressed: _onDeleteButtonPressed,
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

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onEditButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCloth(context: context),
      ),
    );
  }

  void _onDeleteButtonPressed() {
    AlertModal.show(context);
  }
}