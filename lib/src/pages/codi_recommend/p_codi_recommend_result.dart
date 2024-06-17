import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'package:mococo_mobile/src/widgets/tags.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';


class CodiRecommendResult extends StatefulWidget {
  const CodiRecommendResult({
    super.key,
    required this.codi
  });

  final Codi codi;

  @override
  State<CodiRecommendResult> createState() => _CodiRecommendResultState();
}

class _CodiRecommendResultState extends State<CodiRecommendResult> {

  late ClothesList clothesList;
  bool isLoading = true;
  late Codi codi;
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  late List<int> selectedClothesIds;

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
    codi = widget.codi;
    selectedClothesIds = [];
    for (var item in codi.clothes.list) {
      selectedClothesIds.add(item.id);
    }
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    DateWidget(isCenter: false, isEditable: false, date: codi.date),
                    const Spacer(),
                    WeatherWidget(isSmall: true, isEditable: false, weather: codi.weather),
                  ],
                ),
                const SizedBox(height: 6),
                // TODO: 코디 사진
                Container(
                  height: 370,
                  color: Colors.black12,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ScheduleTags(schedule: codi.schedule)
                ),
                const Divider(color: Color(0xffF0F0F0),),
                const SizedBox(height: 8),
                // TODO: 의류 데이터 가져와서 연결 <- 제거..?
                // Expanded(
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(right: 8),
                //           child: GestureDetector(
                //             onTap: () {},
                //             child: Image.asset(IconPath.topSample,),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 8),
                //           child: GestureDetector(
                //             onTap: () {},
                //             child: Container(color: Colors.black12, width:150,),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(right: 8),
                //           child: GestureDetector(
                //             onTap: () {},
                //             child: Container(color: Colors.black12, width:150,),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16)
              ],
            ),
          ),
          SearchBottomSheet(sheetPosition: 0.2, setSelectedStatus: setSearchStatus, selectedClothesIds: selectedClothesIds),
        ],
      ),
    );
  }

  void setSearchStatus(bool status) {
    setState(() {
      isClothesSelected = status;
    });
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

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed() {
    Map<String, dynamic> selectedInfo = {
      'date': codi.date,
      'schedule': codi.schedule,
      'clothingIds': selectedClothesIds
    };

    if (selectedInfo.values.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "옷 선택은 필수입니다.",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
          )
      );
    } else {
      AlertModal.show(
        context,
        message: '코디를 기록하시겠습니까?',
        onConfirm: () {
          _showLoadingDialog(context);
          addCodi(selectedInfo).then((_) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "코디 기록 완료",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(seconds: 1),
                )
            );
          });
        },
      );
    }
  }
}
