import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tags.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_clothes.dart';
import 'package:mococo_mobile/src/pages/closet/p_closet.dart';

class ClothesDetail extends StatefulWidget {
  const ClothesDetail({Key? key, required this.clothes}) : super(key: key);
  final Clothes clothes;

  @override
  _ClothesDetailState createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {

  @override
  Widget build(BuildContext context) {
    final clothes = widget.clothes;

    return Scaffold(
      appBar: TextTitleAppBar(
        title: "상세 정보",
        buttonNum: 2,
        onBackButtonPressed: _onBackButtonPressed,
        onEditButtonPressed: () => _onEditButtonPressed(context),
        onDeleteButtonPressed: () => _onDeleteButtonPressed(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Index: ${clothes.id}'),
            SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: Image.asset(clothes.image),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryTag(primaryCategory: clothes.primaryCategory, subCategory: clothes.subCategory),
                  ColorTag(colorList: List<String>.from(clothes.colors.toList())),
                  DetailTag(detailList: List<String>.from(clothes.detailTags.toList())),
                  Column(children: [
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
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "착용 횟수",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "  "+widget.clothes.wearCount.toString()+"번",
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
                                "  "+widget.clothes.lastWornDate.toString(),
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
                  ],
                  ),
                ],
              ),
            ),
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
        builder: (context) => EditClothes(context: context, clothes: widget.clothes),
      ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    AlertModal.show(
      context,
      message: '해당 의류를 삭제하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Closet()));
      },
    );
  }
}
