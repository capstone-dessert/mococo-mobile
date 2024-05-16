import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/my_location.dart';
import 'package:mococo_mobile/src/data/network.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/pages/codi_recommend/p_codi_recommend_result.dart';

class CodiRecommend extends StatefulWidget {
  const CodiRecommend({Key? key}) : super(key: key);


  @override
  State<CodiRecommend> createState() => _CodiRecommendState();
}

class _CodiRecommendState extends State<CodiRecommend> {

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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getLocation();
  // }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    myLatitude = myLocation.currentLatitude;
    myLongitude = myLocation.currentLongitude;
    print(myLatitude);
    print(myLongitude);

    Network network = Network('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1');

    var weatherData = await network.getJsonData();
    print(weatherData);
  }

  // void fetchData() async {
  //
  //     var myJson = weatherData['weather'][0]['description'];
  //     print(myJson);
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

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
            const Weather(isSmall: false, isEditable: true,),
            const SizedBox(height: 16),
            ScheduleTagPicker(setSelectedScheduleTag: setSelectedScheduleTag),
            const Spacer(),
            // 추천 버튼
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SizedBox(
                width: 345,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CodiRecommendResult()));
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



