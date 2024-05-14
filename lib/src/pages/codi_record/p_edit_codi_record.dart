import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/editable_date.dart';
import 'package:mococo_mobile/src/widgets/editable_weather.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

class EditCodiRecord extends StatefulWidget {
  const EditCodiRecord({super.key});

  @override
  State<EditCodiRecord> createState() => _EditCodiRecordState();
}

class _EditCodiRecordState extends State<EditCodiRecord> {

  Set<int> selectedClothesIndex = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title: "코디 수정", buttonNum: 3, onBackButtonPressed: _onBackButtonPressed, onSaveButtonPressed: _onSaveButtonPressed,),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Row(
                  children: [
                    EditableDate(isCenter: false,),
                    Spacer(),
                    EditableWeather(isSmall: true)
                  ],
                ),
                const SizedBox(height: 6),
                // TODO: 코디 사진
                Container(
                  height: 370,
                  color: Colors.black12,
                ),
                const SizedBox(height: 8),
                const ScheduleTagPicker(),
              ],
            ),
          ),
          const SearchBottomSheet(queries: ["전체"],),
        ],
      ),
    );
  }

  void _onBackButtonPressed() {
    AlertModal.show(
      context,
      message: '수정을 취소하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void _onSaveButtonPressed() {
    // TODO: saveButton
  }
}


