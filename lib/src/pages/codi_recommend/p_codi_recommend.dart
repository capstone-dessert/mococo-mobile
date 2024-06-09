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
  DateTime selectedDate = DateTime.now();

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

  void onDateChanged(DateTime newDate) {
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

      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
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
      minTemperature ??= await getMinTemperature(x, y, baseDate, baseTime);

      setState(() {
        maxTemperature = maxTemperature;
        minTemperature = minTemperature;
        precipitationType = precipitationType;
        skyState = skyState;
      });

      // String fcstDate = weatherItems.isNotEmpty ? weatherItems[0]['fcstDate'] : '';
      // print('${fcstDate}의 최고 기온은 ${maxTemperature}도 입니다.');
      // print('${fcstDate}의 최저 기온은 ${minTemperature}도 입니다.');
      // print('${fcstDate}의 강수 형태는 ${precipitationType}입니다.');
      // print('${fcstDate}의 하늘 상태는 ${skyState}입니다.');

    } else {
      print('현재 위치를 가져올 수 없습니다.');
    }
  }

  Future<double?> getMinTemperature(int x, int y, String baseDate, String baseTime) async {

    // 어제 예보한 오늘 날짜 최저 기온을 받아오기 위해 따로 계산
    DateTime selectedDateTime = selectedDate;
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
              date: selectedDate,
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
                  onPressed: onRecommendButtonPressed,
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

  void onRecommendButtonPressed() {
    // print("All Clothes:");
    // clothesList.listAll.forEach((item) {
    //   print("${item.primaryCategory}: ${item.subCategory} (${item.styles.join(', ')}, ${item.colors.join(', ')})");
    // });

    // 의류 필터링
    minTemperature = 15;
    maxTemperature = 25;
    List<Clothes> filteredClothes = filterClothes(clothesList.listAll, minTemperature, maxTemperature, selectedScheduleTag);

    // 부모 아이템 선택
    print("Parent Item:");
    Clothes? parentItem = getRandomParentItem(filteredClothes);
    print(
        "${parentItem?.primaryCategory}: ${parentItem?.subCategory} (${parentItem
            ?.styles.join(', ')}, ${parentItem?.colors.join(', ')})");

    // 자식 아이템 선택
    print("Child Item:");
    List<Clothes> childItems = getChildItems(clothesList.listAll, parentItem);
    childItems.forEach((item) {
      print("${item.primaryCategory}: ${item.subCategory} (${item.styles.join(', ')}, ${item.colors.join(', ')})");
    });



    // 코디 추천
    // List<Clothes> outfit = selectOutfit(filteredClothes);

    // print("Recommended Outfit:");
    // filteredClothes.forEach((item) {
    //   print(
    //       "${item.primaryCategory}: ${item.subCategory} (${item
    //           .styles.join(', ')}, ${item.colors.join(', ')})");
    // });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CodiRecommendResult(
                scheduleTag: selectedScheduleTag),
      ),
    );
  }

  // TODO 실제 세부 카테고리에 맞게 필터링 항목 수정
  // 날씨 조건에 따른 필터링
  List<Clothes> filterByWeather(List<Clothes> clothesList, double? minTemp, double? maxTemp) {
    List<Clothes> filteredClothes = List.from(clothesList);

    if (minTemp != null && maxTemp != null) {
      if (minTemp >= 23) {
      filteredClothes.removeWhere((item) => item.primaryCategory == "아우터");
      }
      if (minTemp >= 15) {
      filteredClothes.removeWhere((item) => ["후드 티셔츠", "맨투맨", "니트"].contains(item.subCategory));
      }
      if (maxTemp <= 23) {
      filteredClothes.removeWhere((item) => item.subCategory == "민소매 티셔츠");
      }
      if (maxTemp <= 10) {
        filteredClothes.removeWhere((item) => item.primaryCategory == "상의" && item.subCategory == "셔츠/블라우스");
      }
    }
    return filteredClothes;
  }

  // 약속 종류에 따른 필터링
  List<Clothes> filterByOccasion(List<Clothes> clothesList, String? occasion) {
    List<Clothes> filteredClothes = List.from(clothesList);

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

    return finalFilteredClothes;
  }

  // 부모 아이템 선택
  Clothes? getRandomParentItem(List<Clothes> clothesList) {
    List<Clothes> parentItems = clothesList.where((item) => item.primaryCategory == "상의" || item.primaryCategory == "하의").toList();

    if (parentItems.isNotEmpty) {
      return parentItems[Random().nextInt(parentItems.length)];
    } else {
      return null;
    }
  }

  // 스타일 연관성
  final Map<String, List<String>> styleCompatibility = {
    "캐주얼": ["스트릿", "댄디", "스포티", "페미닌"],
    "스트릿": ["캐주얼", "스포티"],
    "댄디": ["캐주얼", "포멀"],
    "스포티": ["캐주얼", "스트릿"],
    "페미닌": ["캐주얼"],
    "포멀": ["댄디"],
  };

  List<Clothes> getChildItems(List<Clothes> clothesList, Clothes? parentItem) {
    if (parentItem == null) {
      return [];
    }

    List<Clothes> childItems = [];

    // 부모의 primary 카테고리를 제외한 카테고리들
    Set<String> allPrimaryCategories = clothesList.map((item) => item.primaryCategory).toSet();
    allPrimaryCategories.remove(parentItem.primaryCategory); // 부모의 primary 카테고리 제외
    List<String> primaryCategories = allPrimaryCategories.toList();

    // 각 카테고리별로 의류들에 대한 점수를 계산
    Map<Clothes, int> itemScores = {};
    for (Clothes item in clothesList) {
      if (item.primaryCategory != parentItem.primaryCategory) {
        int score = 0;
        for (String parentStyle in parentItem.styles) {
          for (String style in item.styles) {
            if (styleCompatibility[parentStyle]?.contains(style) == true) {
              score += 5; // 스타일 연관성에 따라 점수 부여
            }
          }
        }
        itemScores[item] = score;
      }
    }

    // 각 카테고리별 점수를 기반으로 자식으로 선택될 확률을 계산
    List<Clothes> scoredItems = itemScores.keys.toList();
    List<int> scores = itemScores.values.toList();
    int totalScore = scores.reduce((a, b) => a + b);

    if (totalScore > 0) {
      for (int i = 0; i < primaryCategories.length; i++) {
        List<Clothes> categoryItems = scoredItems.where((item) => item.primaryCategory == primaryCategories[i]).toList();
        if (categoryItems.isNotEmpty) {
          int randomValue = Random().nextInt(totalScore);
          int cumulativeScore = 0;

          for (int j = 0; j < categoryItems.length; j++) {
            cumulativeScore += itemScores[categoryItems[j]]!;
            if (randomValue < cumulativeScore) {
              childItems.add(categoryItems[j]);
              break;
            }
          }
        }
      }
    }

    return childItems;
  }

}
