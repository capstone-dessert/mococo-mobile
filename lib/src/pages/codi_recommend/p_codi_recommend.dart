import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/my_location.dart';
import 'package:mococo_mobile/src/data/network.dart';
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

  @override
  void initState() {
    super.initState();
    getLocation(); // 현재 위치 받아오기
  }

  List queries = ["전체"];
  double? myLatitude;
  double? myLongitude;
  String? selectedScheduleTag;
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태

  void setSearchStatus(bool status) {
    setState(() {
      isClothesSelected = status;
    });
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


  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    if (myLocation.currentLatitude != null && myLocation.currentLongitude != null) {
      var gpsToGridData = ConvGridGps.gpsToGRID(
        myLocation.currentLatitude!,
        myLocation.currentLongitude!,
      );
      print(gpsToGridData);

      Network network = Network(
        'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=m7kifi%2BXpjIJm5cl52fdWyftjddfNEbXskzQ9gRK90Q5AK3jzO563UZJf5mCLOGbe6h0v9z6Oc%2BdqdPGwBQRcw%3D%3D&numOfRows=500&pageNo=1&base_date=20240606&base_time=0500&nx=${gpsToGridData['x']}&ny=${gpsToGridData['y']}&dataType=JSON',
      );

      var weatherData = await network.getJsonData();
      var weatherItems = weatherData['response']['body']['items']['item'];
      for (var weatherItem in weatherItems) {
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

      setState(() {
        maxTemperature = maxTemperature;
        minTemperature = minTemperature;
        precipitationType = precipitationType;
        skyState = skyState;
      });
    } else {
      print('현재 위치를 가져올 수 없습니다.');
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
            const Date(isCenter: true, isEditable: true,),
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
            ScheduleTagPicker(selectedScheduleTag: null, setSelectedScheduleTag: setSelectedScheduleTag),
            const Spacer(),
            // 추천 버튼
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SizedBox(
                width: 345,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CodiRecommendResult(scheduleTag: selectedScheduleTag),
                      ),
                    );
                  },
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

  void setQueries(newQueries) {
    setState(() {
      queries.clear();
      queries.addAll(newQueries);
    });
  }
}



