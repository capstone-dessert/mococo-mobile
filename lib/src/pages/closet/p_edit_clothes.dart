import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/new_tag_picker.dart';

class EditClothes extends StatefulWidget {
  const EditClothes({super.key, required this.context, required this.clothes});

  final Clothes clothes;
  final BuildContext context;

  @override
  State<EditClothes> createState() => _EditClothesState();
}

class _EditClothesState extends State<EditClothes> {

  late Clothes clothes;
  late Map<String, dynamic> selectedInfo;

  @override
  void initState() {
    super.initState();
    clothes = widget.clothes;
    selectedInfo = {
      'category': clothes.primaryCategory,
      'subcategory': clothes.subCategory,
      'colors': clothes.colors,
      'tags': clothes.detailTags
    };
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
                child: Image.memory(clothes.image),
              ),
              TagPicker(
                setSelectedInfo: setSelectedInfo,
                selectedPrimaryCategory: clothes.primaryCategory,
                selectedSubcategory: clothes.subCategory,
                selectedColors: Set<String>.from(clothes.colors),
                selectedDetailTags: Set<String>.from(clothes.detailTags),
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }

  void setSelectedInfo(Map<String, dynamic> newSelectedInfo) {
    selectedInfo = newSelectedInfo;
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
        // TODO: 의류 정보 수정
        Navigator.pop(context);
      },
    );
  }
}
