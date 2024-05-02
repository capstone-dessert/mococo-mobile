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
              // SizedBox(width: 5),
              // Text(
              //   "(필수)",
              //   style: TextStyle(fontSize: 14, color: Colors.black87,),
              // ),
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
              // SizedBox(width: 5),
              // Text(
              //   '(중복 선택 가능)',
              //   style: TextStyle(fontSize: 14, color: Colors.black87,),
              // ),
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
                    print(selectedSubCategory);
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


class ColorPickerState extends State<ColorPicker> {
  final List<bool> isSelectiedList = List.filled(8, false);

  // Color myColor = const Color(0xFFFF5722); // deepOrange[400]

  List<Color> colors = [
    Colors.white, //화이트
    Colors.black, //블랙
    Colors.grey, //그레이
    const Color(0xFF37474F), //챠콜
    Colors.red, //빨강
    Colors.purpleAccent, //핑크
    const Color(0xFFFF80AB), //연핑크
    const Color(0xFF000080) // 네이비
  ]; // 색상 샘플

  List<String> checkList = [
    "화이트",
    "블랙",
    "그레이",
    "차콜",
    "빨강",
    "핑크",
    "연핑크",
    "네이비",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      '색상',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '(필수)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  children: List.generate(
                    checkList.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelectiedList[index] = !isSelectiedList[index];
                          });
                        },
                        child: Chip(
                          label: Text(checkList[index]),
                          labelStyle: TextStyle(
                            color: isSelectiedList[index]
                                ? Colors.pink
                                : Colors.black,
                          ),
                          avatar: CircleAvatar(
                            backgroundColor: colors[index],
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black12, // 외곽선 색상
                                  width: 2, // 외곽선 두께
                                ),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                              color: isSelectiedList[index]
                                  ? Colors.pink
                                  : Colors.black38,
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  ColorPickerState createState() => ColorPickerState();
}
