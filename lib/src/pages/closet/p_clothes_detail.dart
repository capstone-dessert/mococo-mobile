import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tags.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_clothes.dart';

class ClothesDetail extends StatefulWidget {
  const ClothesDetail({
    super.key,
    required this.clothesId,
    required this.previousPage,
    required this.reloadListData
  });

  final int clothesId;
  final String previousPage;

  final Function reloadListData;

  @override
  State<ClothesDetail> createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {

  late Clothes clothes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchClothes(widget.clothesId).then((value) {
      setState(() {
        clothes = value;
        isLoading = false;
      });
    });
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black12))
            : SingleChildScrollView(
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
                          CategoryTag(
                              primaryCategory: clothes.primaryCategory,
                              subCategory: clothes.subCategory),
                          StyleTags(styleList: clothes.styles.toList()),
                          ColorTags(colorList: clothes.colors.toList()),
                          DetailTags(
                              detailTagList: clothes.detailTags.toList()),
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
              ));
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(color: Colors.black12),
            ),
          ),
        );
      },
    );
  }

  void reloadClothesData() {
    setState(() {
      isLoading = true;
      fetchClothes(widget.clothesId).then((value) {
        setState(() {
          clothes = value;
          isLoading = false;
        });
      });
    });
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onEditButtonPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => EditClothes(clothes: clothes, reloadClothesData: reloadClothesData)));
  }

  void _onDeleteButtonPressed(BuildContext context) {
    AlertModal.show(
      context,
      message: '해당 의류를 삭제하시겠습니까?',
      onConfirm: () {
        _showLoadingDialog(context);
        deleteClothes([clothes.id]).then((_) {
          widget.reloadListData();
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pop(context);
          if (widget.previousPage == "CodiDetail") {
            Navigator.pop(context);
          }
        });
      },
    );
  }
}
