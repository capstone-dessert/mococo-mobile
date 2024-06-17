import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/clothes_preview.dart';
import 'package:mococo_mobile/src/models/weather.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/search_bottom_sheet.dart';
import 'dart:math';



class AddCodiRecord extends StatefulWidget {
  const AddCodiRecord({
    super.key,
    required this.reloadCodiListData
  });

  final Function reloadCodiListData;

  @override
  State<AddCodiRecord> createState() => _AddCodiRecordState();
}

class _AddCodiRecordState extends State<AddCodiRecord> {
  late ClothesList clothesList;
  bool isLoading = true;
  List<int> selectedClothesIds = [];
  List<Widget> codiImages = [];
  List<ImagePosition> imagePositions = [];
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  String? selectedSchedule;
  late DateTime selectedDate;
  Weather? weather;

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
    selectedDate = DateTime.now();
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
                            getDate: getSelectedDate,
                            setWeather: setWeather,
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      selectedClothesIds.isEmpty
                        ? const SizedBox(
                          height: 400,
                          child: Center(
                            child: Text(
                              "코디할 옷을 선택하세요",
                              style: TextStyle(color: Color(0xff999999), fontSize: 15, fontWeight: FontWeight.w500),
                            )
                          ),
                        )
                        : Container(
                          color: Colors.black12,
                          height: 400,
                          child: Stack(
                            children: _buildPositionedImages(context, MediaQuery.of(context).size.width - 32, MediaQuery.of(context).size.width),
                          ),
                        ),
                      const SizedBox(height: 8),
                      ScheduleTagPicker(selectedSchedule: null, setSelectedSchedule: setSelectedSchedule),
                    ],
                  ),
                ],
            ),
          ),
          SearchBottomSheet(sheetPosition: 0.20, setSelectedStatus: setSelectedStatus, selectedClothesIds: selectedClothesIds),
        ],
      ),
    );
  }

  DateTime getSelectedDate() {
    return selectedDate;
  }

  void setSelectedStatus(bool status) {
    setState(() {
      isClothesSelected = status;
    });
  }

  void setSelectedSchedule(String schedule) {
    setState(() {
      selectedSchedule = schedule;
    });
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

  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
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
    Map<String, dynamic> selectedInfo = {
      'date': selectedDate,
      'schedule': selectedSchedule,
      'clothingIds': selectedClothesIds,
      'addressName': (weather != null) ? weather!.location : null,
      'maxTemperature': (weather != null) ? weather!.maxTemperature : null,
      'minTemperature': (weather != null) ? weather!.minTemperature : null,
      'precipitationType': (weather != null) ? weather!.precipitationType : null,
      'sky': (weather != null) ? weather!.sky : null
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
        message: '코디를 기록하시겠습니까?',
        onConfirm: () {
          _showLoadingDialog(context);
          addCodi(selectedInfo).then((_) {
            widget.reloadCodiListData();
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
