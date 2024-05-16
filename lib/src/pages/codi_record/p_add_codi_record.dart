import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

import '../../components/image_data.dart';

class AddCodiRecord extends StatefulWidget {
  const AddCodiRecord({Key? key}) : super(key: key);

  @override
  State<AddCodiRecord> createState() => _AddCodiRecordState();
}

class _AddCodiRecordState extends State<AddCodiRecord> {
  List<Widget> codiImages = [];
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  List<int> selectedClothesIndices = [];
  String? selectedScheduleTag;

  void setSelectedStatus(bool status) {
    setState(() {
      isClothesSelected = status;
    });
  }

  void setSelectedClothesIndices(List<int> selectedIndices) {
    setState(() {
      selectedClothesIndices = selectedIndices;
    });
  }


  void setSelectedScheduleTag(selectedScheduleTag) {
    setState(() {
      if (selectedScheduleTag == "null") {
        this.selectedScheduleTag = null;
      } else {
        this.selectedScheduleTag = selectedScheduleTag;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "코디 기록",
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
                const Row(
                  children: [
                    Date(isCenter: false, isEditable: true,),
                    Spacer(),
                    Weather(isSmall: true, isEditable: true,)
                  ],
                ),
                const SizedBox(height: 6),
                // ScheduleTagPicker(setSelectedScheduleTag: setSelectedScheduleTag), // 약속 태그 박스 위 위치
                selectedClothesIndices.isEmpty ?
                Container(
                  height: 400,
                  child: const Center(
                      child: Text(
                        "코디할 옷을 선택하세요",
                        style: TextStyle(color: Color(0xff999999), fontSize: 15, fontWeight: FontWeight.w500),
                      )
                  ),
                ) :
                Container(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: selectedClothesIndices.length,
                    children: selectedClothesIndices.map((index) {
                      return _buildClothesImage(index);
                    }).toList(),
                  ),
                ),
              ScheduleTagPicker(setSelectedScheduleTag: setSelectedScheduleTag), // 약속 태그 박스 아래 위치
              ],
            ),
          ),
          SearchBottomSheet(sheetPosition: 0.20, setSelectedStatus: setSelectedStatus, setSelectedClothesIndices: setSelectedClothesIndices),
        ],
      ),
    );
  }

  void _onBackButtonPressed() {
    AlertModal.show(
      context,
      message: '기록을 취소하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void _onSaveButtonPressed() {
    // TODO: 저장 버튼 처리
  }

  Widget _buildClothesImage(int index) {
    return Image.asset(
      IconPath.topSample ?? '',
    );
  }
}
