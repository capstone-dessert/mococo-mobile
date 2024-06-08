import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';


class CodiRecommendResult extends StatefulWidget {
  final String? scheduleTag;

  const CodiRecommendResult({Key? key, required this.scheduleTag}) : super(key: key);

  @override
  State<CodiRecommendResult> createState() => _CodiRecommendResultState();
}

class _CodiRecommendResultState extends State<CodiRecommendResult> {

  DateTime date = DateTime.now();
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  List<int> selectedClothesIndices = [];

  void setSearchStatus(bool status) {
    setState(() {
      isClothesSelected = status;
    });
  }

  void setSelectedClothesIndices(List<int> selectedIndices) {
    setState(() {
      selectedClothesIndices = selectedIndices;
    });
  }

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
                // TODO: 날씨 아이콘
                SizedBox(width: 24, height: 24, child: Image.asset(IconPath.mococoLogo),),
                const SizedBox(width: 6),
                const Text(
                  "전주시",
                  style: TextStyle(fontSize: 16, color: Color(0xff494949), fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                const Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(
                              text: '24℃',
                              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600)
                          ),
                          TextSpan(
                              text: ' / ',
                              style: TextStyle(color: Color(0xff494949), fontSize: 16, fontWeight: FontWeight.w600)
                          ),
                          TextSpan(
                              text: '11℃',
                              style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600)
                          )
                        ]
                    )
                ),
              ],
            ),
            const SizedBox(height: 6),
            // TODO: 코디 사진
            Container(
              height: 370,
              color: Colors.black12,
            ),
            const SizedBox(height: 8),
            widget.scheduleTag != null ?
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      backgroundColor: const Color(0xffF9F9F9),
                      label: Text(widget.scheduleTag!),
                      labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xffCACACA),),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(), // 약속 종류 선택 안 하면 표시 X
            const Divider(color: Color(0xffF0F0F0),),
            const SizedBox(height: 8),
            // TODO: 의류 데이터 가져와서 연결
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {},
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
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed() {
    print("Save");
  }
}
