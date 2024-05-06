import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/category.dart';

import '../components/image_data.dart';

// view
class CategoryTag extends StatefulWidget {
  const CategoryTag({Key? key, required this.primaryCategory, this.subCategory}) : super(key: key);

  final String primaryCategory;
  final String? subCategory;

  @override
  _CategoryTagState createState() => _CategoryTagState();
}

class _CategoryTagState extends State<CategoryTag> {
  late List<String> subCategories;

  @override
  Widget build(BuildContext context) {
    final primaryCategories = Category.getPrimaryCategories();
    subCategories = Category.getSubCategories(widget.primaryCategory);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "카테고리",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (var primaryCategory in primaryCategories)
                if (primaryCategory == widget.primaryCategory)
                  Chip(
                    backgroundColor: const Color(0xffF9F9F9),
                    label: Text(primaryCategory),
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: const Color(0xffCACACA)),
                    ),
                  ),
              if (widget.subCategory != null &&
                  subCategories.contains(widget.subCategory))
                Chip(
                  backgroundColor: const Color(0xffF9F9F9),
                  label: Text(widget.subCategory!),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: const Color(0xffCACACA)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


class ColorTag extends StatefulWidget {
  const ColorTag({Key? key, required this.colorList}) : super(key: key);

  final List<String> colorList;

  @override
  _ColorTagState createState() => _ColorTagState();
}

class _ColorTagState extends State<ColorTag> {
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
          const Text(
            "색상",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (var colorData in colors)
                if (widget.colorList.contains(colorData[0]))
                  Chip(
                    backgroundColor: const Color(0xffF9F9F9),
                    avatar: CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xffD9D9D9),
                      child: CircleAvatar(
                        radius: 9,
                        backgroundColor: colorData[1],
                      ),
                    ),
                    label: Text(colorData[0]),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(color: Color(0xffCACACA)),
                    ),
                  ),
            ],
          )
        ],
      ),
    );
  }
}


class DetailTag extends StatefulWidget {
  final List<String> detailList;

  const DetailTag({Key? key, required this.detailList}) : super(key: key);

  @override
  State<DetailTag> createState() => _DetailTagState();
}

class _DetailTagState extends State<DetailTag> {
  List<String> detailTags = [];

  @override
  void initState() {
    super.initState();
    detailTags = widget.detailList;
  }

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
                "세부 태그",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: detailTags.map((detail) {
              return Chip(
                backgroundColor: const Color(0xffF9F9F9),
                label: Text(detail),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: const BorderSide(
                    color: Color(0xffCACACA),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}





// select
class PrimaryCategoryTagPicker extends StatefulWidget {
  const PrimaryCategoryTagPicker({super.key, required this.setSelectedPrimaryCategory});

  final Function(String) setSelectedPrimaryCategory;

  @override
  PrimaryCategoryTagPickerState createState() => PrimaryCategoryTagPickerState();
}

class PrimaryCategoryTagPickerState extends State<PrimaryCategoryTagPicker> {

  int selectedIndex = -1;
  List primaryCategories = Category.getPrimaryCategories();

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
              primaryCategories.length,
              (index) {
                return ChoiceChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  selectedColor: const Color(0xffFFF0F0),
                  label: Text(primaryCategories[index]),
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
                    widget.setSelectedPrimaryCategory(selected ? primaryCategories[index] : "null");
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

  List<String> subCategories = [];
  Set<String> selectedSubCategories = {};

  @override
  Widget build(BuildContext context) {
    subCategories = Category.getSubCategories(widget.primaryCategory);
    selectedSubCategories.removeWhere((element) => !subCategories.contains(element));
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
              subCategories.length,
                (index) {
                return FilterChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  selectedColor: const Color(0xffFFF0F0),
                  label: Text(subCategories[index]),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selectedSubCategories.contains(subCategories[index])
                        ? const Color(0xffF6747E)
                        : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: selectedSubCategories.contains(subCategories[index])
                          ? const Color(0xffF6747E)
                          : const Color(0xffCACACA),
                    ),
                  ),
                  selected: selectedSubCategories.contains(subCategories[index]),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedSubCategories.add(subCategories[index]);
                      } else {
                        selectedSubCategories.remove(subCategories[index]);
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
                  selectedColor: const Color(0xffFFF0F0),
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
    );
  }
}


class DetailTagPicker extends StatefulWidget {
  const DetailTagPicker({super.key});

  @override
  State<DetailTagPicker> createState() => _DetailTagPickerState();
}

class _DetailTagPickerState extends State<DetailTagPicker> {

  List detailTags = ["브랜드", "패턴", "기장", "소매"];
  Set<String> selectedDetailTags = {};

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
                "세부 태그",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),
              ),
              SizedBox(width: 10),
              Text(
                "브랜드, 패턴, 기장, 소재 등",
                style: TextStyle(fontSize: 13, color: Color(0xff777777)),
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 35,
            child: SearchBar(
              leading: SizedBox(child: Image.asset(IconPath.searchBar)),
              backgroundColor: const MaterialStatePropertyAll(Color(0xffF0F0F0)),
              elevation: const MaterialStatePropertyAll(0),
              hintText: "검색",
              hintStyle: MaterialStateProperty.all(const TextStyle(color: Color(0xffBDBDBD), fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 8,
            children: List.generate(
              detailTags.length,
                  (index) {
                return FilterChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  selectedColor: const Color(0xffFFF0F0),
                  label: Text(detailTags[index]),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selectedDetailTags.contains(detailTags[index])
                        ? const Color(0xffF6747E)
                        : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: selectedDetailTags.contains(detailTags[index])
                          ? const Color(0xffF6747E)
                          : const Color(0xffCACACA),
                    ),
                  ),
                  selected: selectedDetailTags.contains(detailTags[index]),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedDetailTags.add(detailTags[index]);
                      } else {
                        selectedDetailTags.remove(detailTags[index]);
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


class ScheduleTagPicker extends StatefulWidget {
  const ScheduleTagPicker({super.key});

  @override
  State<ScheduleTagPicker> createState() => _ScheduleTagPickerState();
}

class _ScheduleTagPickerState extends State<ScheduleTagPicker> {

  List scheduleTags = ["데이트", "운동", "출근"];
  Set<String> selectedScheduleTags = {};

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
                "약속 종류",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List.generate(
              scheduleTags.length,
                  (index) {
                return FilterChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  selectedColor: const Color(0xffFFF0F0),
                  label: Text(scheduleTags[index]),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selectedScheduleTags.contains(scheduleTags[index])
                        ? const Color(0xffF6747E)
                        : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: selectedScheduleTags.contains(scheduleTags[index])
                          ? const Color(0xffF6747E)
                          : const Color(0xffCACACA),
                    ),
                  ),
                  selected: selectedScheduleTags.contains(scheduleTags[index]),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedScheduleTags.add(scheduleTags[index]);
                      } else {
                        selectedScheduleTags.remove(scheduleTags[index]);
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

