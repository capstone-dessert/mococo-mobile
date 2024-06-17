import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
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

  bool isLoading = true;

  List queries = ["전체"];
  double? myLatitude;
  double? myLongitude;
  String? selectedSchedule;
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
        selectedSchedule = null;
      } else {
        selectedSchedule = selectedScheduleTag;
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

  void onRecommendButtonPressed() async {
    Map<String, dynamic> selectedInfo = {
      'date': selectedDate,
      'weather': weather,
      'schedule': selectedSchedule,
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
      _showLoadingDialog(context);
      Map<String, dynamic> data = {
        "minTemperature": weather!.minTemperature,
        "maxTemperature": weather!.maxTemperature,
        "schedule": selectedSchedule
      };
      recommend(data).then((value) {
        List<int> selectedClothesIds = value;
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodiRecommendResult(
              date: selectedDate,
              weather: weather!,
              schedule: selectedSchedule!,
              selectedClothesIds: selectedClothesIds,
            ),
          ),
        );
      });
    }
  }
}
