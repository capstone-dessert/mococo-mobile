import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

class EditClothes extends StatefulWidget {
  const EditClothes({super.key, required this.context, required this.clothes});

  final Clothes clothes;
  final BuildContext context;

  @override
  State<EditClothes> createState() => _EditClothesState();
}

class _EditClothesState extends State<EditClothes> {

  late Clothes clothes;
  String? selectedPrimaryCategory;
  String? selectedSubCategory;
  Set<String> selectedColors = {};
  Set<String> selectedDetailTags = {};

  @override
  void initState() {
    super.initState();
    clothes = widget.clothes;
    selectedPrimaryCategory = clothes.primaryCategory;
    selectedSubCategory = clothes.subCategory;
    selectedColors = clothes.colors as Set<String>;
    selectedDetailTags = clothes.detailTags as Set<String>;
  }

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
      appBar: TextTitleAppBar(
        title: "상세 정보 수정",
        buttonNum: 3,
        onSaveButtonPressed: _onSaveButtonPressed,
        onBackButtonPressed: _onBackButtonPressed,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: Image.asset(widget.clothes.image),
              ),
              PrimaryCategoryTagPicker(
                selectedPrimaryCategory: selectedPrimaryCategory,
                setSelectedPrimaryCategory: setSelectedPrimaryCategory,
              ),
              const Divider(color: Color(0xffF0F0F0),),
              if (selectedPrimaryCategory != null)
                Column(
                  children: [
                    SubCategoryTagSinglePicker(
                      primaryCategory: selectedPrimaryCategory!,
                      selectedSubCategory: selectedSubCategory,
                    ),
                    const Divider(color: Color(0xffF0F0F0),),
                  ],
                ),
              ColorTagPicker(selectedColors: selectedColors),
              const Divider(color: Color(0xffF0F0F0),),
              DetailTagPicker(selectedDetailTags: selectedDetailTags),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    AlertModal.show(
      context,
      message: '정보 수정을 취소하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void _onSaveButtonPressed() {
    AlertModal.show(
      context,
      message: '상세 정보를 저장하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
      },
    );
  }
}
