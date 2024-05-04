import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';

import '../../components/image_data.dart';
import '../closet/p_search.dart';

class CodiRecommendResult extends StatefulWidget {
  const CodiRecommendResult({super.key});

  @override
  State<CodiRecommendResult> createState() => _CodiRecommendResultState();
}

class _CodiRecommendResultState extends State<CodiRecommendResult> {

  DateTime date = DateTime.now();
  List tags = ["데이트"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "추천 코디",
        buttonNum: 3,
        onBackButtonPressed: _onBackButtonPressed,
        onSaveButtonPressed: _onSaveButtonPressed,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 6),
                Text(
                  "${date.year.toString()}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                // 날씨 아이콘
                SizedBox(width: 24, height: 24, child: Image.asset(IconPath.mococoLogo),),
                const SizedBox(width: 6),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '24℃',
                        style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600)
                      ),
                      TextSpan(
                        text: ' / ',
                        style: TextStyle(color: Color(0xff494949), fontSize: 15, fontWeight: FontWeight.w600)
                      ),
                      TextSpan(
                        text: '11℃',
                        style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600)
                      )
                    ]
                  )
                ),
                const SizedBox(width: 7),
                const Text(
                  "전주시",
                  style: TextStyle(fontSize: 16, color: Color(0xff494949), fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(height: 6),
            Container(
              height: 370,
              color: Colors.black12,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                spacing: 8,
                children: List.generate(
                  tags.length,
                    (index) {
                    return Chip(
                      backgroundColor: const Color(0xffF9F9F9),
                      label: Text(tags[index]),
                      labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xffCACACA),),
                      ),
                    );}
                )
              ),
            ),
            const Divider(color: Color(0xffF0F0F0),),
            const SizedBox(height: 8),
            // 의류 사진
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {_showModalBottomSheet(["상의"]);}, // 카테고리 ... 나중에..
                        child: Image.asset(IconPath.topSample,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(color: Colors.black12, width:150,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(color: Colors.black12, width:150,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      )
    );
  }

  void _showModalBottomSheet(queries) {
    int itemCount = 9; // 아이템 개수 나중에 수정
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        elevation: 0,
        useRootNavigator: true,
        constraints: BoxConstraints(
          // maxHeight: MediaQuery.of(context).size.height - 120,
          maxHeight: MediaQuery.of(context).size.height - 600,
          minHeight: MediaQuery.of(context).size.height - 600,
          minWidth: MediaQuery.of(context).size.width
        ),
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                          List.generate(
                            queries.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Chip(
                                  backgroundColor: const Color(0xffF9F9F9),
                                  label: Text(queries[index]),
                                  labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: const BorderSide(color: Color(0xffCACACA),),
                                ),
                              ),
                            );
                          }
                        ) + [
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: GestureDetector(
                              onTap: () async {
                                var newQueries =  await Get.to(() => const SearchClothes(), arguments: queries.toSet());
                                if (newQueries == [] || newQueries == null) {
                                  queries = ["전체"];
                                } else {
                                  queries = newQueries;
                                }
                              },
                              child: Chip(
                                backgroundColor: const Color(0xffF9F9F9),
                                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                                label: Image.asset(IconPath.searchTag, width: 20,),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(color: Color(0xffF6747E),),
                                ),

                              ),
                            ),
                          ),]
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('$itemCount개',),
                          const Spacer()
                        ],
                      ),
                      // TODO: GridviewPage 띄우기
                      // GridviewPage()
                    ],
                  )

                ],
              ),
            ),
          );
        }
    );
  }

  // void _showModalBottomSheet() {
  //   Get.bottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(20),
  //           topRight: Radius.circular(20),
  //         )
  //     ),
  //     Padding(
  //       padding: EdgeInsets.all(16),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         constraints: BoxConstraints(
  //           minHeight: 250,
  //           maxHeight: MediaQuery.of(context).size.height - 150,
  //         ),
  //         child: Column(
  //           children: [
  //
  //           ],
  //         ),
  //       ),
  //     )
  //   );
  // }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed() {
    print("Save");
  }
}
