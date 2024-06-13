import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/models/weather.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/pages/codi_recommend/p_codi_recommend_result.dart';

class CodiRecommend extends StatefulWidget {
  const CodiRecommend({super.key});

  @override
  State<CodiRecommend> createState() => _CodiRecommendState();
}

class _CodiRecommendState extends State<CodiRecommend> {

  // 날씨 정보
  double? maxTemperature;
  double? minTemperature;
  int? precipitationType;
  int? skyState;
  DateTime selectedDate = DateTime.now();
  String? selectedLocation;

  Weather? weather;

  late ClothesList clothesList;
  List? selectedClothes;

  bool isLoading = true;

  List queries = ["전체"];
  double? myLatitude;
  double? myLongitude;
  String? selectedScheduleTag;
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CenterLogoAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            DateWidget(
              isCenter: true,
              isEditable: true,
              date: selectedDate,
              onDateChanged: onDateChanged,
            ),
            const SizedBox(height: 16),
            WeatherWidget(
              isSmall: false,
              isEditable: true,
              getDate: getSelectedDate,
              setSelectedLocation: setSelectedLocation,
              setWeather: setWeather,
            ),
            const SizedBox(height: 16),
            ScheduleTagPicker(
              selectedSchedule: null,
              setSelectedSchedule: setSelectedScheduleTag
            ),
            const Spacer(),
            // 추천 버튼
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SizedBox(
                width: 345,
                height: 50,
                child: FilledButton(
                  onPressed: onRecommendButtonPressed,
                  style: TextButton.styleFrom(backgroundColor: const Color(0xffF6747E)),
                  child: const Text(
                    "추천받기",
                    style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  DateTime getSelectedDate() {
    return selectedDate;
  }

  void setSelectedLocation(String location) {
    selectedLocation = location;
  }

  void setWeather(Weather newWeather) {
    weather = newWeather;
  }

  void onRecommendButtonPressed() async {
    // TODO: 코디 추천 결과(clothes) 가져오기
    ByteData data = await DefaultAssetBundle.of(context).load('assets/images/topSample.png');
    Uint8List imageBytes = data.buffer.asUint8List();

    Map<String, dynamic> selectedInfo = {
      'id': 0,
      'date': DateFormat('yyyy-MM-dd').format(selectedDate),
      'image': 'assets/images/topSample.png',
      'weather': weather,
      'schedule': selectedScheduleTag,
      'clothingItems': [{'id': 1, 'image': imageBytes}], // TODO: -> selectedClothes
    };
    if (selectedInfo.values.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "스케줄 선택은 필수입니다.",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
          )
      );
    } else {
      Codi codi = Codi.fromJson(selectedInfo);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CodiRecommendResult(codi: codi),
        ),
      );
    }
  }
}
