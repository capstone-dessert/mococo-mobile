import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/category.dart';
import 'package:mococo_mobile/src/components/image_data.dart';

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
  const SubCategoryTagPicker({
    Key? key,
    required this.primaryCategory,
    required this.selectedSubCategories,
  }) : super(key: key);

  final String primaryCategory;
  final Set<String> selectedSubCategories;

  @override
  State<SubCategoryTagPicker> createState() => _SubCategoryTagPickerState();
}

class _SubCategoryTagPickerState extends State<SubCategoryTagPicker> {
  late List<String> subCategories;
  late Set<String> selectedSubCategories;

  @override
  void initState() {
    super.initState();
    // 초기 상태 설정
    subCategories = Category.getSubCategories(widget.primaryCategory);
    selectedSubCategories = widget.selectedSubCategories;
  }

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
          ),
        ],
      ),
    );
  }
}


class ColorTagPicker extends StatefulWidget {
  const ColorTagPicker({Key? key, required this.selectedColors,}) : super(key: key);

  final Set<String> selectedColors;

  @override
  State<ColorTagPicker> createState() => _ColorTagPickerState();
}

class _ColorTagPickerState extends State<ColorTagPicker> {
  Set<String> selectedColors = {};

  @override
  void initState() {
    super.initState();
    // 초기 상태 설정
    selectedColors = widget.selectedColors;
  }

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
  const DetailTagPicker({Key? key, required this.selectedDetailTags,}) : super(key: key);

  final Set<String> selectedDetailTags;

  @override
  State<DetailTagPicker> createState() => _DetailTagPickerState();
}

class _DetailTagPickerState extends State<DetailTagPicker> {

  List detailTags = ["브랜드", "패턴", "기장", "소매"];
  Set<String> selectedDetailTags = {};

  @override
  void initState() {
    super.initState();
    // 초기 상태 설정
    selectedDetailTags = widget.selectedDetailTags;
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
  const ScheduleTagPicker({Key? key, required this.setSelectedScheduleTag,}) : super(key: key);

  final Function(String) setSelectedScheduleTag;

  @override
  State<ScheduleTagPicker> createState() => _ScheduleTagPickerState();
}

class _ScheduleTagPickerState extends State<ScheduleTagPicker> {

  List scheduleTags = ["데이트", "운동", "출근"];
  String? selectedScheduleTag;

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
                return ChoiceChip(
                  showCheckmark: false,
                  backgroundColor: const Color(0xffF9F9F9),
                  selectedColor: const Color(0xffFFF0F0),
                  label: Text(scheduleTags[index]),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selectedScheduleTag == scheduleTags[index]
                        ? const Color(0xffF6747E)
                        : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: selectedScheduleTag == scheduleTags[index]
                          ? const Color(0xffF6747E)
                          : const Color(0xffCACACA),
                    ),
                  ),
                  selected: selectedScheduleTag == scheduleTags[index],
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        selectedScheduleTag = scheduleTags[index];
                      });
                      widget.setSelectedScheduleTag(scheduleTags[index]);
                    }
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
