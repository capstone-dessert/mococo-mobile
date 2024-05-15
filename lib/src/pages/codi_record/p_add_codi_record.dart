import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

class AddCodiRecord extends StatefulWidget {
  const AddCodiRecord({Key? key}) : super(key: key);

  @override
  State<AddCodiRecord> createState() => _AddCodiRecordState();
}

class _AddCodiRecordState extends State<AddCodiRecord> {
  Set<int> selectedClothesIndex = {};
  String? selectedScheduleTag;

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
      appBar: TextTitleAppBar(title: "코디 기록", buttonNum: 3, onBackButtonPressed: _onBackButtonPressed, onSaveButtonPressed: _onSaveButtonPressed,),
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
                if (selectedClothesIndex.isEmpty)
                  Container(
                    height: 370,
                    child: const Center(
                        child: Text(
                          "코디할 옷을 선택하세요",
                          style: TextStyle(color: Color(0xff999999), fontSize: 15, fontWeight: FontWeight.w500),
                        )
                    ),
                  ),
                // TODO: 코디 사진
                if (selectedClothesIndex.isNotEmpty)
                  Container(
                    height: 370,
                    color: Colors.black12,
                  ),
                // const SizedBox(height: 8),
                ScheduleTagPicker(setSelectedScheduleTag: setSelectedScheduleTag),
              ],
            ),
          ),
          const SearchBottomSheet(sheetPosition: 0.20),
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
}