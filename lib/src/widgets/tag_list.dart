import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/category.dart';

class PrimaryCategoryTagPicker extends StatefulWidget {
  const PrimaryCategoryTagPicker({super.key, required this.setSelectedPrimaryCategory});

  final Function(String) setSelectedPrimaryCategory;

  @override
  PrimaryCategoryTagPickerState createState() => PrimaryCategoryTagPickerState();
}

class PrimaryCategoryTagPickerState extends State<PrimaryCategoryTagPicker> {

  int selectedIndex = -1;
  List primaryCategory = Category.getPrimaryCategory();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "카테고리",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List.generate(
              primaryCategory.length,
              (index) {
                return ChoiceChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  label: Text(primaryCategory[index]),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selectedIndex == index
                      ? const Color(0xffF6747E)
                      : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: selectedIndex == index
                        ? const Color(0xffF6747E)
                        : const Color(0xffCACACA),
                    ),
                  ),
                  selected: selectedIndex == index,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedIndex = selected ? index : -1;
                    });
                    widget.setSelectedPrimaryCategory(selected ? primaryCategory[index] : "null");
                  },
                );
              },
            ),
          ),
         ],
      ),
    );
  }
}


class SubCategoryTagPicker extends StatefulWidget {
  const SubCategoryTagPicker({super.key, required this.primaryCategory});

  final String primaryCategory;

  @override
  State<SubCategoryTagPicker> createState() => _SubCategoryTagPickerState();
}

class _SubCategoryTagPickerState extends State<SubCategoryTagPicker> {

  List<String> subCategory = [];
  Set<String> selectedSubCategory = {};

  @override
  Widget build(BuildContext context) {
    subCategory = Category.getSubCategory(widget.primaryCategory);
    selectedSubCategory.removeWhere((element) => !subCategory.contains(element));
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "하위 카테고리",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List.generate(
              subCategory.length,
                (index) {
                return FilterChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  label: Text(subCategory[index]),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selectedSubCategory.contains(subCategory[index])
                        ? const Color(0xffF6747E)
                        : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: selectedSubCategory.contains(subCategory[index])
                          ? const Color(0xffF6747E)
                          : const Color(0xffCACACA),
                    ),
                  ),
                  selected: selectedSubCategory.contains(subCategory[index]),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedSubCategory.add(subCategory[index]);
                      } else {
                        selectedSubCategory.remove(subCategory[index]);
                      }
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


class ColorTagPicker extends StatefulWidget {
  const ColorTagPicker({super.key});

  @override
  State<ColorTagPicker> createState() => _ColorTagPickerState();
}

class _ColorTagPickerState extends State<ColorTagPicker> {

  List colors = [
    ["화이트", Colors.white],
    ["블랙", Colors.black],
    ["그레이", const Color(0xffCDCDCD)],
    ["차콜", const Color(0xff6D6D6D)],
    ["빨강", Colors.red],
    ["핑크", const Color(0xffFF63CA)],
    ["네이비", const Color(0xff002F89)],
    ["파랑", const Color(0xff0057FF)],
    ["하늘", const Color(0xffAFECFF)],
    ["보라", const Color(0xff7D00FA)],
    ["카키", const Color(0xff5C7300)],
    ["초록", Colors.green],
    ["민트", const Color(0xff9BFFCE)],
    ["노랑", Colors.yellow],
    ["주황", Colors.orange],
    ["베이지", const Color(0xffEBDDCC)],
    ["브라운", Colors.brown]
  ];
  Set<String> selectedColors = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "색상",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List.generate(
              colors.length,
                  (index) {
                return FilterChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  avatar: colors[index][1] == Colors.white
                    ? CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xffD9D9D9),
                      child: CircleAvatar(
                        radius: 9,
                        backgroundColor: colors[index][1],
                      ),
                    )
                    : CircleAvatar(
                      radius: 30,
                      backgroundColor: colors[index][1],
                    ),
                  label: Text(colors[index][0]),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selectedColors.contains(colors[index][0])
                        ? const Color(0xffF6747E)
                        : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: selectedColors.contains(colors[index][0])
                          ? const Color(0xffF6747E)
                          : const Color(0xffCACACA),
                    ),
                  ),
                  selected: selectedColors.contains(colors[index][0]),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedColors.add(colors[index][0]);
                      } else {
                        selectedColors.remove(colors[index][0]);
                      }
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );;
  }
}

