import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
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

  late Future<Clothes> clothesFuture;
  late Clothes clothes;

  @override
  void initState() {
    super.initState();
    clothesFuture = fetchClothes(widget.clothesId);
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
      body: FutureBuilder(
        future: clothesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.black12,));
          } else if (snapshot.hasError) {
            return Text('FutureBuilder Error: ${snapshot.error}');
          } else {
            clothes = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 180,
                    child: Image.memory(clothes.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryTag(primaryCategory: clothes.primaryCategory,
                            subCategory: clothes.subCategory),
                        ColorTags(colorList: clothes.colors.toList()),
                        DetailTags(detailTagList: clothes.detailTags.toList()),
                        // Column(children: [
                        //   // Text(
                        //   //   "정보",
                        //   //   style: TextStyle(
                        //   //     fontSize: 20,
                        //   //     fontWeight: FontWeight.w700,
                        //   //   ),
                        //   // ),
                        //   Padding(
                        //     padding: const EdgeInsets.only(top:5, left: 8),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             const Text(
                        //               "착용 횟수",
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //             Text(
                        //               "  ${clothes.wearCount}번",
                        //               style: const TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.w400,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(height: 5,),
                        //         Row(
                        //           children: [
                        //             const Text(
                        //               "마지막 착용 날짜",
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //             Text(
                        //               "  ${clothes.lastWornDate}",
                        //               style: const TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.w400,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Closet()));
      },
    );
  }
}
