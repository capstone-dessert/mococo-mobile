import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_clothes.dart';
import '../../components/image_data.dart';
import '../../widgets/alert_modal.dart';
import '../../widgets/app_bar.dart';
import '../../clothes.dart';
import '../../widgets/clothes_details.dart';

class ClothesDetail extends StatefulWidget {
  const ClothesDetail({super.key, required this.clothes});
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          children: [
            // SizedBox(
            //   height: 30,
            // ),
            Text('Index: ${widget.clothes.index}'),
            SizedBox(
              height: 180,
              child: Image.asset(IconPath.topSample),
            ),
            const detailsCatView(),
            // const detailsColorView(),
          ],
        ),
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
    AlertModal.show(context, "해당 의류를 삭제하시겠습니까?", true); // 삭제 상황 여부 = true
  }
}
