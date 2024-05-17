import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

class EditClothes extends StatefulWidget {
  final Clothes clothes;
  final BuildContext context;
  const EditClothes({Key? key, required this.context, required this.clothes}) : super(key: key);

  @override
  _EditClothesState createState() => _EditClothesState();
}

class _EditClothesState extends State<EditClothes> {
  String? selectedPrimaryCategory;
  Set<String> selectedSubCategories = {};
  Set<String> selectedColors = {};
  Set<String> selectedDetailTags = {};

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
              SizedBox(height: 20),
              Text('Index: ${widget.clothes.id}'),
              SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: Image.asset(widget.clothes.image),
              ),
              PrimaryCategoryTagPicker(setSelectedPrimaryCategory: setSelectedPrimaryCategory,),
              Divider(color: Color(0xffF0F0F0),),
              if (selectedPrimaryCategory != null)
                Column(
                  children: [
                    SubCategoryTagPicker(primaryCategory: selectedPrimaryCategory!, selectedSubCategories: selectedSubCategories),
                    Divider(color: Color(0xffF0F0F0),),
                  ],
                ),
              ColorTagPicker(selectedColors: selectedColors),
              Divider(color: Color(0xffF0F0F0),),
              DetailTagPicker(selectedDetailTags: selectedDetailTags),
              SizedBox(height: 16)
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
