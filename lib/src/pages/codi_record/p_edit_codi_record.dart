import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

class EditCodiRecord extends StatefulWidget {
  const EditCodiRecord({super.key, required this.codiItem});

  final Map codiItem;

  @override
  State<EditCodiRecord> createState() => _EditCodiRecordState();
}

class _EditCodiRecordState extends State<EditCodiRecord> {

  Set<int> selectedClothesIndex = {};
  Map codiItem = {};
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
    codiItem = widget.codiItem;
    return Scaffold(
      appBar: TextTitleAppBar(title: "코디 수정", buttonNum: 3, onBackButtonPressed: _onBackButtonPressed, onSaveButtonPressed: _onSaveButtonPressed,),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Date(isCenter: false, isEditable: true, date: codiItem["date"],),
                    const Spacer(),
                    Weather(isSmall: true, isEditable: true, location: codiItem["location"],)
                  ],
                ),
                const SizedBox(height: 6),
                // TODO: 코디 사진
                Container(
                  height: 370,
                  child: Image.asset(codiItem["image"]),
                ),
                const SizedBox(height: 8),
                ScheduleTagPicker(setSelectedScheduleTag: setSelectedScheduleTag),
              ],
            ),
          ),
          const SearchBottomSheet(),
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


