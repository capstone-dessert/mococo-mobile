import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/jsons.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tags.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_clothes.dart';
import 'package:mococo_mobile/src/pages/closet/p_closet.dart';

class ClothesDetail extends StatefulWidget {
  const ClothesDetail({super.key, required this.clothesId});

  final int clothesId;

  @override
  State<ClothesDetail> createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {

  late Clothes clothes;

  @override
  void initState() {
    super.initState();
    clothes = Clothes.fromJson(getClothesJsonById(widget.clothesId)!);
  }

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
                  ColorTags(colorList: List<String>.from(clothes.colors.toList())),
                  DetailTags(detailTagList: List<String>.from(clothes.detailTags.toList())),
                  Column(children: [
                    // Text(
                    //   "정보",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top:5, left: 8),
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
                                "  " + clothes.wearCount.toString()+"번",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
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
                                "  " + clothes.lastWornDate.toString(),
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
        builder: (context) => EditClothes(context: context, clothes: clothes),
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
