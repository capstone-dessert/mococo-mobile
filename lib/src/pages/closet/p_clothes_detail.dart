import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_clothes.dart';
import '../../components/image_data.dart';
import '../../widgets/alert_modal.dart';
import '../../widgets/app_bar.dart';
import '../../clothes.dart';
import '../../widgets/clothes_details.dart';
import '../../widgets/tag_list.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Index: ${widget.clothes.index}'),
              SizedBox(
                height: 180,
                child: Image.asset(IconPath.topSample),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryTag(primaryCategory: '상의', subCategory: '반소매 티셔츠'),
                ],
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    ColorTag(colorList: ["빨강", "주황"]),
                  ],
                ),
              ),
             const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailTag(detailList: ["나이키", "체크 패턴"]),
                ],
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "정보",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
              padding: EdgeInsets.only(left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "정보",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " |",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " 3회",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "마지막 착용 날짜",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " |",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " 2024",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
