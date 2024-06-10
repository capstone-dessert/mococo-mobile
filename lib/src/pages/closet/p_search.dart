import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/data/tag_data.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/clothes_tag_picker.dart';

class SearchClothes extends StatefulWidget {
  const SearchClothes({super.key});

  @override
  SearchClothesState createState() => SearchClothesState();
}

class SearchClothesState extends State<SearchClothes> {

  late Map<String, dynamic> selectedInfo;

  List<String> queries = [];

  @override
  void initState() {
    super.initState();
    selectedInfo = {
      'category': null,
      'subcategory': null,
      'colors': null,
      'tags': null
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "검색",
        buttonNum: 0,
        onBackButtonPressed: _onBackButtonPressed,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClothesTagPicker(
                detailTagPickerMode: DetailTagPickerMode.search,
                setSelectedInfo: setSelectedInfo
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 83,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12))),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xffCACACA)
                        )
                      ),
                      onPressed: () {
                        setState(() {
                          selectedInfo = {
                            'category': null,
                            'subcategory': null,
                            'colors': null,
                            'tags': null
                          };
                        });
                      },
                      child: const Text(
                        "초기화",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 52,
                    child: FilledButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xffF6747E),
                      ),
                      onPressed: () {
                        setQueries();
                        ClothesList clothesList;
                        if (queries == ["전체"]) {
                          _showLoadingDialog(context);
                          fetchClothesAll().then((value) {
                            clothesList = value;
                            Navigator.pop(context);
                            Get.back(result: {'newQueries': queries, 'clothesList': clothesList});
                          }).catchError((error) {
                            print("Error fetching clothes list: $error");
                          });
                        } else {
                          _showLoadingDialog(context);
                          searchClothes(selectedInfo).then((value) {
                            clothesList = value;
                            Navigator.pop(context);
                            Get.back(result: {'newQueries': queries, 'clothesList': clothesList});
                          }).catchError((error) {
                            print("Error fetching clothes list: $error");
                          });
                        }
                      },
                      child: const Text(
                        "검색",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ],
        )
      ),
    );
  }

  void setSelectedInfo(Map<String, dynamic> newSelectedInfo) {
    selectedInfo = newSelectedInfo;
    print(selectedInfo);
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
    Get.back();
  }

  void setQueries() {
    queries.clear();

    if (selectedInfo['category'] != null) {
      queries.add(selectedInfo['category']);
    }
    if (selectedInfo['subcategory'] != null) {
      queries.add(selectedInfo['subcategory']);
    }
    if (selectedInfo['colors'] != null) {
      queries.addAll(selectedInfo['colors'].toList());
    }
    if (selectedInfo['detailTags'] != null) {
      queries.addAll(selectedInfo['detailTags'].toList());
    }

    if (queries.isEmpty) {
      queries.add("전체");
    }
  }
}
