import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/my_location.dart';
import 'package:mococo_mobile/src/data/network.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/pages/codi_recommend/p_codi_recommend_result.dart';
import 'package:intl/intl.dart';

import '../../models/clothes.dart';
import '../../models/clothes_list.dart';
import '../../service/http_service.dart';

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
  String selectedDate = DateFormat('yyyy.MM.dd').format(DateTime.now());

  late ClothesList clothesList;
  late Clothes clothes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation(); // 현재 위치 받아오기
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
  }

  List queries = ["전체"];
  double? myLatitude;
  double? myLongitude;
  String? selectedScheduleTag;
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태

  void setSelectedScheduleTag(selectedScheduleTag) {
    setState(() {
      if (selectedScheduleTag == "null") {
        this.selectedScheduleTag = null;
      } else {
        this.selectedScheduleTag = selectedScheduleTag;
      }
    });
  }

  void onDateChanged(String newDate) {
    setState(() {
      selectedDate = newDate;
      getLocation();
    });
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();

    if (myLocation.currentLatitude != null && myLocation.currentLongitude != null) {
      var gpsToGridData = ConvGridGps.gpsToGRID(
        myLocation.currentLatitude!,
        myLocation.currentLongitude!,
      );

      int x = gpsToGridData['x'];
      int y = gpsToGridData['y'];

      print(x);
      print(y);

      String formattedDate = selectedDate.replaceAll('.', '');
      String baseDate = formattedDate; // 발표 날짜 (선택 날짜)
      String baseTime = '0500'; // 발표 시간

      // 발표 날짜 포함하여 ~3일 날씨 정보 가져옴
      Network network = Network(
        'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=m7kifi%2BXpjIJm5cl52fdWyftjddfNEbXskzQ9gRK90Q5AK3jzO563UZJf5mCLOGbe6h0v9z6Oc%2BdqdPGwBQRcw%3D%3D&numOfRows=809&pageNo=1&base_date=$baseDate&base_time=$baseTime&nx=63&ny=90&dataType=JSON',
        // 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=m7kifi%2BXpjIJm5cl52fdWyftjddfNEbXskzQ9gRK90Q5AK3jzO563UZJf5mCLOGbe6h0v9z6Oc%2BdqdPGwBQRcw%3D%3D&numOfRows=809&pageNo=1&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y&dataType=JSON',
      );

      var weatherData = await network.getJsonData();
      var weatherItems = weatherData['response']['body']['items']['item'];
      for (var weatherItem in weatherItems) {
        String fcstDate = weatherItem['fcstDate'];

        // 선택된 날짜의 예보 정보만 가져오기
        if (fcstDate == baseDate) {
          String category = weatherItem['category'];
          dynamic fcstValue = weatherItem['fcstValue'];

          switch (category) {
            case 'TMX':
              maxTemperature = double.tryParse(fcstValue.toString());
              break;
            case 'TMN':
              minTemperature = double.tryParse(fcstValue.toString());
              break;
            case 'PTY':
              precipitationType = int.tryParse(fcstValue.toString());
              break;
            case 'SKY':
              skyState = int.tryParse(fcstValue.toString());
              break;
            default:
              break;
          }
        }
      }
      // 만약 최저 기온이 null인 경우, getMinTemperature() 함수를 호출하여 값을 가져와서 대체
      if (minTemperature == null) {
        minTemperature = await getMinTemperature();
      }

      setState(() {
        maxTemperature = maxTemperature;
        minTemperature = minTemperature;
        precipitationType = precipitationType;
        skyState = skyState;
      });


      String fcstDate = weatherItems.isNotEmpty ? weatherItems[0]['fcstDate'] : '';
      print('${fcstDate}의 최고 기온은 ${maxTemperature}도 입니다.');
      print('${fcstDate}의 최저 기온은 ${minTemperature}도 입니다.');
      print('${fcstDate}의 강수 형태는 ${precipitationType}입니다.');
      print('${fcstDate}의 하늘 상태는 ${skyState}입니다.');



    } else {
      print('현재 위치를 가져올 수 없습니다.');
    }
  }

  Future<double?> getMinTemperature() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();

    if (myLocation.currentLatitude != null &&
        myLocation.currentLongitude != null) {
      var gpsToGridData = ConvGridGps.gpsToGRID(
        myLocation.currentLatitude!,
        myLocation.currentLongitude!,
      );

      int x = gpsToGridData['x'];
      int y = gpsToGridData['y'];

      // 현재 날짜 최저 기온을 받아오기 위해 따로 저장
      DateTime selectedDateTime = DateFormat('yyyy.MM.dd').parse(selectedDate);
      DateTime yesterdayDateTime = selectedDateTime.subtract(Duration(days: 1));
      String yesterdayDate = DateFormat('yyyyMMdd').format(yesterdayDateTime);

      String baseDate = yesterdayDate;
      String baseTime = '0500';

      // 발표 날짜 포함하여 ~3일 날씨 정보 가져옴
      Network networkMin = Network(
        'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=m7kifi%2BXpjIJm5cl52fdWyftjddfNEbXskzQ9gRK90Q5AK3jzO563UZJf5mCLOGbe6h0v9z6Oc%2BdqdPGwBQRcw%3D%3D&numOfRows=500&pageNo=1&base_date=$baseDate&base_time=$baseTime&nx=63&ny=90&dataType=JSON',
        // 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=m7kifi%2BXpjIJm5cl52fdWyftjddfNEbXskzQ9gRK90Q5AK3jzO563UZJf5mCLOGbe6h0v9z6Oc%2BdqdPGwBQRcw%3D%3D&numOfRows=500&pageNo=1&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y&dataType=JSON',
      );

      var weatherData = await networkMin.getJsonData();
      var weatherItems = weatherData['response']['body']['items']['item'];
      double? minTemperature;
      for (var weatherItem in weatherItems) {
        String fcstDate = weatherItem['fcstDate'];
        String selectedDate = DateFormat('yyyyMMdd').format(selectedDateTime);

        // 선택한 날짜의 최저 기온 예보 정보만 가져오기
        if (fcstDate == selectedDate) {
          String category = weatherItem['category'];
          dynamic fcstValue = weatherItem['fcstValue'];

          switch (category) {
            case 'TMN':
              minTemperature = double.tryParse(fcstValue.toString());
              break;
            default:
              break;
          }
        }
      }

      return minTemperature;
    }
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
            Date(
              isCenter: true,
              isEditable: true,
              date: DateTime.parse(selectedDate.replaceAll('.', '-')),
              onDateChanged: onDateChanged,
            ),
            const SizedBox(height: 16),
            Weather(
              isSmall: false,
              isEditable: true,
              maxTemperature: maxTemperature,
              minTemperature: minTemperature,
              precipitationType: precipitationType,
              skyState: skyState,
            ),
            const SizedBox(height: 16),
            NewScheduleTagPicker(selectedSchedule: null,
                setSelectedSchedule: setSelectedScheduleTag),
            const Spacer(),
            // 추천 버튼
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SizedBox(
                width: 345,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    print("All Clothes:");
                    clothesList.listAll.forEach((item) {
                      print(
                          "${item.primaryCategory}: ${item.subCategory} (${item
                              .styles.join(', ')}, ${item.colors.join(', ')})");
                    });

                    // 의류 필터링
                    List<Clothes> filteredClothes = filterClothes(
                        clothesList.listAll, minTemperature, maxTemperature,
                        selectedScheduleTag);

                    // 코디 추천
                    // List<Clothes> outfit = selectOutfit(filteredClothes);

                    print("Recommended Outfit:");
                    filteredClothes.forEach((item) {
                      print(
                          "${item.primaryCategory}: ${item.subCategory} (${item
                              .styles.join(', ')}, ${item.colors.join(', ')})");
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CodiRecommendResult(
                                scheduleTag: selectedScheduleTag),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffF6747E)),
                  child: const Text(
                    "추천받기",
                    style: TextStyle(fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setQueries(newQueries) {
    setState(() {
      queries.clear();
      queries.addAll(newQueries);
    });
  }

  // 날씨 조건에 따른 필터링
  List<Clothes> filterByWeather(List<Clothes> clothesList, double? minTemp, double? maxTemp) {
    List<Clothes> filteredClothes = List.from(clothesList);

    if (minTemp != null && maxTemp != null) {
      if (minTemp >= 23) {
      filteredClothes.removeWhere((item) => item.primaryCategory == "outer");
      }
      if (minTemp >= 15) {
      filteredClothes.removeWhere((item) => ["hoodie", "sweater", "knit"].contains(item.subCategory));
      }
      if (maxTemp <= 23) {
      filteredClothes.removeWhere((item) => item.subCategory == "tank top");
      }
      if (maxTemp <= 10) {
        filteredClothes.removeWhere((item) => item.primaryCategory == "top" && item.subCategory == "shirt");
      }
    }
    return filteredClothes;
  }

  // 약속 종류에 따른 필터링
  List<Clothes> filterByOccasion(List<Clothes> clothesList, String? occasion) {
    List<Clothes> filteredClothes = List.from(clothesList);

    // TODO 실제 세부 카테고리에 맞게 추가해야 함
    if (occasion != null) {
      if (["결혼", "면접", "출근"].contains(occasion)) {
        filteredClothes.removeWhere((item) => ["민소매 티셔츠", "후드 티셔츠", "스포츠 상의"].contains(item.subCategory));
      } else if (occasion == "발표") {
        filteredClothes.removeWhere((item) => ["민소매 티셔츠", "후드 티셔츠"].contains(item.subCategory));
      } else if (occasion == "운동") {
        filteredClothes.removeWhere((item) => ["셔츠/블라우스", "니트", "슬랙스", "치마"].contains(item.subCategory)
            || item.primaryCategory == "원피스");
      }
    }
    return filteredClothes;
  }

  List<Clothes> filterClothes(List<Clothes> clothesList, double? minTemp, double? maxTemp, String? occasion) {
    List<Clothes> weatherFilteredClothes = filterByWeather(clothesList, minTemp, maxTemp);
    List<Clothes> finalFilteredClothes = filterByOccasion(weatherFilteredClothes, occasion);

    // return weatherFilteredClothes;
    return finalFilteredClothes;
  }
}
