import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/tag_data.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/clothes_tag_picker.dart';

class EditClothes extends StatefulWidget {
  const EditClothes({
    super.key,
    required this.clothes,
    required this.reloadClothesData
  });

  final Clothes clothes;
  final Function reloadClothesData;

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
      'styles': clothes.styles.toList(),
      'colors': clothes.colors.toList(),
      'tags': clothes.detailTags.toList(),
    };
    // print(selectedInfo);
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
              ClothesTagPicker(
                detailTagPickerMode: DetailTagPickerMode.edit,
                setSelectedInfo: setSelectedInfo,
                selectedPrimaryCategory: clothes.primaryCategory,
                selectedSubcategory: clothes.subCategory,
                selectedStyles: Set<String>.from(clothes.styles),
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
    if (selectedInfo.values.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "각 태그 선택은 필수입니다.",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 1),
        )
      );
    } else {
      AlertModal.show(
        context,
        message: '수정된 정보를 저장하시겠습니까?',
        onConfirm: () {
          _showLoadingDialog(context);

          List newDetailTags = [];
          for (var tag in selectedInfo['tags']) {
            if (!Tag.detailTags.contains(tag)) {
              newDetailTags.add(tag);
            }
          }
          Tag.addDetailTags(newDetailTags);

          selectedInfo['image'] = clothes.image;
          editClothes(clothes.id, selectedInfo).then((_) {
            widget.reloadClothesData();
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context);
          });
        },
      );
    }
  }
}
