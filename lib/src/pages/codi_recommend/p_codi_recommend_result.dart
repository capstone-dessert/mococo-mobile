import 'dart:math';
import 'dart:typed_data';
import 'dart:ui'as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mococo_mobile/src/data/image_position.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/clothes_preview.dart';
import 'package:mococo_mobile/src/models/weather.dart';
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
    required this.date,
    required this.weather,
    required this.selectedClothesIds,
    required this.schedule
  });

  final DateTime date;
  final Weather weather;
  final List<int> selectedClothesIds;
  final String schedule;

  @override
  State<CodiRecommendResult> createState() => _CodiRecommendResultState();
}

class _CodiRecommendResultState extends State<CodiRecommendResult> {

  late ClothesList clothesList;
  bool isLoading = true;
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  late List<int> selectedClothesIds;
  List<ImagePosition> imagePositions = [];

  var globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
    selectedClothesIds = widget.selectedClothesIds;
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
                      DateWidget(isCenter: false, isEditable: false, date: widget.date),
                      const Spacer(),
                      WeatherWidget(isSmall: true, isEditable: false, weather: widget.weather),
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
                    : RepaintBoundary(
                      key: globalKey,
                      child: Container(
                        color: Colors.white60,
                        height: 400,
                        child: Stack(
                          children: _buildPositionedImages(context, MediaQuery.of(context).size.width - 32, MediaQuery.of(context).size.width),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ScheduleTags(schedule: widget.schedule)
                  ),
                  const Divider(color: Color(0xffF0F0F0),),
                  const SizedBox(height: 16)
                ],
              ),
            ),
            SearchBottomSheet(
              sheetPosition: 0.2,
              setSelectedStatus: setSearchStatus,
              selectedClothesIds: selectedClothesIds,
              imagePositions: imagePositions,
            ),
          ],
      ),
    );
  }

  void setSearchStatus(bool status) {
    setState(() {
      isClothesSelected = status;
    });
  }

  void _handleDrag(DragUpdateDetails details, int index) {
    setState(() {
      imagePositions[index] = ImagePosition(
        imagePositions[index].left + details.delta.dx,
        imagePositions[index].top + details.delta.dy,
      );
    });
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
      ClothesPreview clothesPreview = clothesList.list.firstWhere((clothes) => clothes.id == entry.value);

      if (index < clothesList.list.length) {
        double left;
        double top;
        if (index < imagePositions.length) {
          left = imagePositions[index].left;
          top = imagePositions[index].top;
        } else {
          if (clothesPreview.category == "상의") {
            left = 0.3 * (MediaQuery.of(context).size.width - 32);
            top = 0.1 * MediaQuery.of(context).size.width;
          } else if (clothesPreview.category == "하의") {
            left = 0.3 * (MediaQuery.of(context).size.width - 32);
            top = 0.45 * MediaQuery.of(context).size.width;
          } else {
            left = Random().nextDouble() * (MediaQuery.of(context).size.width - 32);
            top = Random().nextDouble() * MediaQuery.of(context).size.width;
          }
          imagePositions.insert(index, ImagePosition(left, top));
        }
        left = left.clamp(-10, containerWidth - 150);
        top = top.clamp(-35, containerHeight - 150);

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

  Future<Uint8List?> _capture() async {
    var renderObject = globalKey.currentContext!.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    }
    return null;
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed() {
    Map<String, dynamic> selectedInfo = {
      'date': widget.date,
      'schedule': widget.schedule,
      'clothingIds': selectedClothesIds,
      'addressName': widget.weather.location,
      'maxTemperature': widget.weather.maxTemperature,
      'minTemperature': widget.weather.minTemperature,
      'precipitationType': widget.weather.precipitationType,
      'sky': widget.weather.sky
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
          _capture().then((value) {
            var img = value;
            selectedInfo['image'] = img;
            addCodi(selectedInfo).then((_) {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pop(context);
            });
          });
        },
      );
    }
  }
}
