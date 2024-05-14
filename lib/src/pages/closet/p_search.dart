import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

class SearchClothes extends StatefulWidget {
  const SearchClothes({super.key});

  @override
  SearchClothesState createState() => SearchClothesState();
}

class SearchClothesState extends State<SearchClothes> {

  // TODO: 위젯에서 쿼리 받아오기
  Set queries = {};
  String? selectedPrimaryCategory;

  void setSelectedPrimaryCategory(selectedPrimaryCategory) {
    setState(() {
      if (selectedPrimaryCategory == "null") {
        this.selectedPrimaryCategory = null;
      } else {
        this.selectedPrimaryCategory = selectedPrimaryCategory;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    queries = Get.arguments;
    queries.remove("전체");
    return Scaffold(
      appBar: TextTitleAppBar(title: "검색", buttonNum: 0, onBackButtonPressed: _onBackButtonPressed,),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrimaryCategoryTagPicker(setSelectedPrimaryCategory: setSelectedPrimaryCategory,),
              const Divider(color: Color(0xffF0F0F0),),
              if (selectedPrimaryCategory != null)
                Column(
                  children: [
                    SubCategoryTagPicker(primaryCategory: selectedPrimaryCategory!),
                    const Divider(color: Color(0xffF0F0F0),),
                  ],
                ),
              const ColorTagPicker(),
              const Divider(color: Color(0xffF0F0F0),),
              const DetailTagPicker(),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 83,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12))
        ),
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
                        side: const BorderSide(color: Color(0xffCACACA))
                      ),
                      onPressed: () { queries.clear(); },
                      child: const Text(
                        "초기화",
                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
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
                        Get.back(result: queries.toList());
                      },
                      child: const Text(
                        "검색",
                        style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
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

  void _onBackButtonPressed() {
    Get.back();
  }
}
