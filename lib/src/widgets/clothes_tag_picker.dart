import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/tag_data.dart';
import 'package:mococo_mobile/src/widgets/tag_pickers.dart';

class ClothesTagPicker extends StatefulWidget {
  const ClothesTagPicker({
    super.key,
    required this.isEditable,
    required this.setSelectedInfo,
    this.selectedPrimaryCategory,
    this.selectedSubcategory,
    this.selectedStyles,
    this.selectedColors,
    this.selectedDetailTags,
  });

  final bool isEditable;

  final Function setSelectedInfo;

  final String? selectedPrimaryCategory;
  final String? selectedSubcategory;
  final Set<String>? selectedStyles;
  final Set<String>? selectedColors;
  final Set<String>? selectedDetailTags;
  @override
  State<ClothesTagPicker> createState() => _ClothesTagPickerState();
}

class _ClothesTagPickerState extends State<ClothesTagPicker> {
  late Map<String, dynamic> selectedInfo;

  @override
  void initState() {
    super.initState();
    selectedInfo = {
      'category': widget.selectedPrimaryCategory,
      'subcategory': widget.selectedSubcategory,
      'styles': (widget.selectedStyles != null) ? widget.selectedStyles!.toList() : null,
      'colors': (widget.selectedColors != null) ? widget.selectedColors!.toList() : null,
      'tags': (widget.selectedDetailTags != null) ? widget.selectedDetailTags!.toList() : null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CategoryTagPicker(
            setSelectedInfoValue: setSelectedInfoValue,
            selectedPrimaryCategory: widget.selectedPrimaryCategory,
            selectedSubcategory: widget.selectedSubcategory
          ),
          const Divider(color: Color(0xffF0F0F0)),
          StyleTagPicker(
            setSelectedInfoValue: setSelectedInfoValue,
            selectedStyles: widget.selectedStyles
          ),
          const Divider(color: Color(0xffF0F0F0)),
          ColorTagPicker(
            setSelectedInfoValue: setSelectedInfoValue,
            selectedColors: widget.selectedColors
          ),
          const Divider(color: Color(0xffF0F0F0)),
          DetailTagPicker(
            isEditable: widget.isEditable,
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
