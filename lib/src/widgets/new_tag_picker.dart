import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/new_tag_pickers.dart';

class TagPicker extends StatefulWidget {
  const TagPicker({
    super.key,
    required this.setSelectedInfo,
    this.selectedPrimaryCategory,
    this.selectedSubcategory,
    this.selectedColors,
    this.selectedDetailTags
  });

  final Function setSelectedInfo;

  final String? selectedPrimaryCategory;
  final String? selectedSubcategory;
  final Set<String>? selectedColors;
  final Set<String>? selectedDetailTags;

  @override
  State<TagPicker> createState() => _TagPickerState();
}

class _TagPickerState extends State<TagPicker> {

  late Map<String, dynamic> selectedInfo;

  @override
  void initState() {
    super.initState();
    selectedInfo = {
      'category': widget.selectedPrimaryCategory,
      'subcategory': widget.selectedSubcategory,
      'colors': widget.selectedColors,
      'tags': widget.selectedDetailTags
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          NewCategoryTagPicker(
            setSelectedInfoValue: setSelectedInfoValue,
            selectedPrimaryCategory: widget.selectedPrimaryCategory,
            selectedSubcategory: widget.selectedSubcategory
          ),
          const Divider(color: Color(0xffF0F0F0)),
          NewColorTagPicker(
            setSelectedInfoValue: setSelectedInfoValue,
            selectedColors: widget.selectedColors
          ),
          const Divider(color: Color(0xffF0F0F0)),
          NewDetailTagPicker(
            setSelectedInfoValue: setSelectedInfoValue,
            selectedDetailTags: widget.selectedDetailTags
          ),
        ],
      ),
    );
  }

  void setSelectedInfoValue(String key, value) {
    selectedInfo[key] = value;
    widget.setSelectedInfo(selectedInfo);
  }
}
