import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/clothes_preview.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'dart:math';

import '../../service/http_service.dart';

class AddCodiRecord extends StatefulWidget {
  const AddCodiRecord({super.key});

  @override
  State<AddCodiRecord> createState() => _AddCodiRecordState();
}

class _AddCodiRecordState extends State<AddCodiRecord> {

  late ClothesList clothesList;
  bool isLoading = true;
  List<int> selectedClothesIndices = [];
  int? itemCount;
  List<Widget> codiImages = [];
  List<ImagePosition> imagePositions = [];
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  String? selectedSchedule;

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
        itemCount = clothesList.list.length;
      });
    });
  }

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

  void setSelectedScheduleTag(schedule) {
    selectedSchedule = schedule;
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
            child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.black12))
              : Stack(
                children: [
                  const SizedBox(height: 16),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Date(isCenter: false, isEditable: true,),
                        Spacer(),
                        Weather(isSmall: true, isEditable: true,)
                      ],
                    ),
                    const SizedBox(height: 6),
                    selectedClothesIndices.isEmpty ?
                    const SizedBox(
                      height: 400,
                      child: Center(
                          child: Text(
                            "코디할 옷을 선택하세요",
                            style: TextStyle(color: Color(0xff999999), fontSize: 15, fontWeight: FontWeight.w500),
                          )
                      ),
                    ) :
                    Container(
                      color: Colors.black12,
                      height: 400,
                      child: Stack(
                        children: _buildPositionedImages(context, MediaQuery.of(context).size.width - 32, MediaQuery.of(context).size.width),
                      ),
                    ),
                    const SizedBox(height: 8),
                    NewScheduleTagPicker(selectedSchedule: null, setSelectedSchedule: setSelectedScheduleTag),
                  ],
                ),
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
    print(selectedClothesIndices);
    AlertModal.show(
      context,
      message: '코디를 기록하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildClothesImage(ClothesPreview clothesPreview, int index, double imageSize) {
    return GestureDetector(
      onPanUpdate: (details) {
        _handleDrag(details, index);
      },
      child: Image.memory(
        clothesList.list[selectedClothesIndices[index]].image,
        width: imageSize,
      ),
    );
  }

  List<Widget> _buildPositionedImages(BuildContext context, double containerWidth, double containerHeight) {
    return selectedClothesIndices.asMap().entries.map((entry) {
      int index = entry.key;
      if (index < clothesList.list.length) {
        double left;
        double top;
        if (index < imagePositions.length) {
          left = imagePositions[index].left;
          top = imagePositions[index].top;
        } else {
          left = Random().nextDouble() * containerWidth;
          top = Random().nextDouble() * containerHeight;
          imagePositions.add(ImagePosition(left, top));
        }
        left = left.clamp(-10, containerWidth - 150);
        top = top.clamp(-35, containerHeight - 150);

        return Positioned(
          left: left,
          top: top,
          child: _buildClothesImage(clothesList.list[index], index, 150),
        );
      } else {
        return const SizedBox();
      }
    }).toList();
  }


  void _handleDrag(DragUpdateDetails details, int index) {
    setState(() {
      imagePositions[index] = ImagePosition(
        imagePositions[index].left + details.delta.dx,
        imagePositions[index].top + details.delta.dy,
      );
    });
  }
}

class ImagePosition {
  double left;
  double top;

  ImagePosition(this.left, this.top);
}
