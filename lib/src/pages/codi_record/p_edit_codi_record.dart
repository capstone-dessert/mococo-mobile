import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/clothes_preview.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'dart:math';

class EditCodiRecord extends StatefulWidget {
  const EditCodiRecord({
    super.key,
    required this.codiItem,
    required this.reloadCodiData
  });

  final Codi codiItem;

  final Function reloadCodiData;

  @override
  State<EditCodiRecord> createState() => _EditCodiRecordState();
}

class _EditCodiRecordState extends State<EditCodiRecord> {

  late final ClothesList clothesList;
  bool isLoading = true;
  List<int> selectedClothesIndices = [];
  Set<int> selectedClothesIndex = {};
  late Codi codiItem;
  List<Widget> codiImages = [];
  List<ImagePosition> imagePositions = [];
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  String? selectedSchedule;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
    codiItem = widget.codiItem;
    selectedDate = codiItem.date;
    selectedSchedule = codiItem.schedule;
    for (var clothesPreview in codiItem.clothes.list) {
      selectedClothesIndices.add(clothesPreview.id);
    }
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

  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    codiItem = widget.codiItem;
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "코디 수정",
        buttonNum: 3,
        onBackButtonPressed: _onBackButtonPressed,
        onSaveButtonPressed: _onSaveButtonPressed,
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.black12))
        : Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Date(
                        isCenter: false,
                        isEditable: true,
                        date: selectedDate,
                        onDateChanged: onDateChanged,
                      ),
                      const Spacer(),
                      Weather(isSmall: true, isEditable: true, location: codiItem.weather.location,)
                    ],
                  ),
                  const SizedBox(height: 6),
                  selectedClothesIndices.isEmpty ?
                  Container(
                    color: Colors.black12,
                    height: 400,
                    child: const Center(
                      child: Text(
                        "기존 코디",
                        style: TextStyle(color: Color(0xff999999), fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ),
                    // child: Image.asset(codiItem!.image),  // TODO: 기존 코디 사진 불러오기
                  ) :
                  Container(
                    color: Colors.black12,
                    height: 400,
                    child: Stack(
                      children: _buildPositionedImages(context, MediaQuery.of(context).size.width - 32, MediaQuery.of(context).size.width),
                    ),
                  ),
                  const SizedBox(height: 8),
                  NewScheduleTagPicker(selectedSchedule: selectedSchedule, setSelectedSchedule: setSelectedScheduleTag),
                ],
              ),
            ),
            SearchBottomSheet(sheetPosition: 0.2, setSelectedStatus: setSelectedStatus, setSelectedClothesIndices: setSelectedClothesIndices),
          ],
        ),
    );
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
    AlertModal.show(
      context,
      message: '수정을 취소하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void _onSaveButtonPressed() {
    List<int> selectedClothesIds = [];
    for (var clothesIndices in selectedClothesIndices) {
      selectedClothesIds.add(clothesList.list[clothesIndices].id);
    }
    Map<String, dynamic> selectedInfo = {
      'date': selectedDate,
      'schedule': selectedSchedule,
      'clothingIds': selectedClothesIds
    };

    if (selectedInfo.values.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "스케줄과 옷 선택은 필수입니다.",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
          )
      );
    } else {
      AlertModal.show(
        context,
        message: '코디를 수정하시겠습니까?',
        onConfirm: () {
          _showLoadingDialog(context);
          editCodi(codiItem.id, selectedInfo).then((_) {
            widget.reloadCodiData();
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context);
          });
        },
      );
    }
  }

  Widget _buildClothesImage(ClothesPreview clothesPreview, int index, double imageSize) {
    return GestureDetector(
      onPanUpdate: (details) {
        _handleDrag(details, index);
      },
      child: Image.memory(
        clothesList.list[index].image,
        width: imageSize,
      ),
    );
  }

  List<Widget> _buildPositionedImages(BuildContext context, double containerWidth, double containerHeight) {
    return selectedClothesIndices.asMap().entries.map((entry) {
      int index = entry.key;
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
      left = left.clamp(-10, containerWidth - 140);
      top = top.clamp(-35, containerHeight - 150);

      return Positioned(
        left: left,
        top: top,
        child: _buildClothesImage(clothesList.list[index], entry.value, 150),
      );
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



