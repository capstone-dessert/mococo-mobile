import 'package:flutter/material.dart';
import '../../components/image_data.dart';
import '../../widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/pages/closet/p_edit_clothes.dart';
import '../../components/image_data.dart';
import '../../widgets/alert_modal.dart';
import '../../widgets/app_bar.dart';
import '../../clothes.dart';
import '../../widgets/clothes_details.dart';
import '../../widgets/tag_list.dart';

class EditClothes extends StatefulWidget {
  final Clothes clothes;
  final BuildContext context;
  const EditClothes({Key? key, required this.context, required this.clothes}) : super(key: key);

  @override
  _EditClothesState createState() => _EditClothesState();
}

class _EditClothesState extends State<EditClothes> {
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
              Text('Index: ${widget.clothes.index}'),
              SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: Image.asset(widget.clothes.imagePath),
              ),
              PrimaryCategoryTagPicker(setSelectedPrimaryCategory: setSelectedPrimaryCategory,),
              Divider(color: Color(0xffF0F0F0),),
              if (selectedPrimaryCategory != null)
                Column(
                  children: [
                    SubCategoryTagPicker(primaryCategory: selectedPrimaryCategory!),
                    Divider(color: Color(0xffF0F0F0),),
                  ],
                ),
              ColorTagPicker(),
              Divider(color: Color(0xffF0F0F0),),
              DetailTagPicker(),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed() {
    print("save");
  }
}
