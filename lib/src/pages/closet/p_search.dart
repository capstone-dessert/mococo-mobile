import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/tag_list.dart';

class SearchClothes extends StatefulWidget {
  const SearchClothes({super.key});

  @override
  SearchClothesState createState() => SearchClothesState();
}

class SearchClothesState extends State<SearchClothes> {

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
    return Scaffold(
      appBar: const TextTitleAppBar(title: "검색", buttonNum: 0),
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

            ],
          ),
        ),
      ),
    );
  }
}
