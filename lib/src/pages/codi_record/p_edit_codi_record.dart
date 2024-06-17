import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/clothes_preview.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/models/weather.dart';
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
  List<int> selectedClothesIds = [];
  List<ImagePosition> imagePositions = [];
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  String? selectedSchedule;
  late DateTime selectedDate;
  late Weather weather;

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
    selectedDate = widget.codiItem.date;
    selectedSchedule = widget.codiItem.schedule;
    weather = widget.codiItem.weather;
    for (var clothesPreview in widget.codiItem.clothes.list) {
      selectedClothesIds.add(clothesPreview.id);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      DateWidget(
                        isCenter: false,
                        isEditable: true,
                        date: selectedDate,
                        onDateChanged: onDateChanged,
                      ),
                      const Spacer(),
                      WeatherWidget(
                        isSmall: true,
                        isEditable: true,
                        weather: weather,
                        getDate: getSelectedDate,
                        setWeather: setWeather,
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    color: Colors.white60,
                    height: 400,
                    child: Stack(
                      children: _buildPositionedImages(context, MediaQuery.of(context).size.width - 32, MediaQuery.of(context).size.width),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ScheduleTagPicker(selectedSchedule: selectedSchedule, setSelectedSchedule: setSelectedScheduleTag),
                ],
              ),
            ),
            SearchBottomSheet(sheetPosition: 0.2, setSelectedStatus: setSelectedStatus, selectedClothesIds: selectedClothesIds),
          ],
        ),
    );
  }

  void setSelectedStatus(bool status) {
    setState(() {
      isClothesSelected = status;
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

  DateTime getSelectedDate() {
    return selectedDate;
  }

  void setWeather(Weather newWeather) {
    weather = newWeather;
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
    Map<String, dynamic> selectedInfo = {
      'date': selectedDate,
      'schedule': selectedSchedule,
      'clothingIds': selectedClothesIds,
      'addressName': weather.location,
      'maxTemperature': weather.maxTemperature,
      'minTemperature': weather.minTemperature,
      'precipitationType': weather.precipitationType,
      'sky': weather.sky
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
          editCodi(widget.codiItem.id, selectedInfo).then((_) {
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
      child: Image.memory(clothesPreview.image, width: imageSize),
    );
  }

  List<Widget> _buildPositionedImages(BuildContext context, double containerWidth, double containerHeight) {
    return selectedClothesIds.asMap().entries.map((entry) {
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

        // get ClothesPreview by id
        ClothesPreview clothesPreview = clothesList.list.firstWhere((clothes) => clothes.id == entry.value);
        return Positioned(
          left: left,
          top: top,
          child: _buildClothesImage(clothesPreview, index, 150),
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



