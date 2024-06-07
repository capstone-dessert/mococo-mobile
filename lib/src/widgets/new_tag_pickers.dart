import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'package:mococo_mobile/src/data/tag_data.dart';

class NewCategoryTagPicker extends StatefulWidget {
  const NewCategoryTagPicker(
      {super.key,
      required this.setSelectedInfoValue,
      this.selectedPrimaryCategory,
      this.selectedSubcategory});

  final Function setSelectedInfoValue;

  final String? selectedPrimaryCategory;
  final String? selectedSubcategory;

  @override
  State<NewCategoryTagPicker> createState() => _NewCategoryTagPickerState();
}

class _NewCategoryTagPickerState extends State<NewCategoryTagPicker> {
  late List allPrimaryCategories;
  String? selectedPrimaryCategory;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    allPrimaryCategories = Tag.getPrimaryCategories();
    if (widget.selectedPrimaryCategory != null) {
      selectedPrimaryCategory = widget.selectedPrimaryCategory;
      selectedIndex = allPrimaryCategories.indexOf(selectedPrimaryCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.transparent),
        const Text(
          "카테고리",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(allPrimaryCategories.length, (index) {
            return ChoiceChip(
              showCheckmark: false,
              backgroundColor: const Color(0xffF9F9F9),
              selectedColor: const Color(0xffFFF0F0),
              label: Text(allPrimaryCategories[index]),
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
                  selectedIndex = selected ? index : null;
                  selectedPrimaryCategory =
                      selected ? allPrimaryCategories[index] : null;
                  widget.setSelectedInfoValue('subcategory', null);
                  widget.setSelectedInfoValue(
                      'category', selectedPrimaryCategory);
                });
              },
            );
          }),
        ),
        const SizedBox(height: 8),
        if (selectedPrimaryCategory != null) ...[
          const Divider(color: Color(0xffF0F0F0)),
          NewSubcategoryTagPicker(
              setSelectedInfoValue: widget.setSelectedInfoValue,
              primaryCategory: selectedPrimaryCategory!,
              selectedSubcategory: widget.selectedSubcategory)
        ]
      ],
    );
  }
}

class NewSubcategoryTagPicker extends StatefulWidget {
  const NewSubcategoryTagPicker(
      {super.key,
      required this.setSelectedInfoValue,
      required this.primaryCategory,
      this.selectedSubcategory});

  final Function setSelectedInfoValue;

  final String primaryCategory;
  final String? selectedSubcategory;

  @override
  State<NewSubcategoryTagPicker> createState() =>
      _NewSubcategoryTagPickerState();
}

class _NewSubcategoryTagPickerState extends State<NewSubcategoryTagPicker> {
  late List allSubcategories;
  String? selectedSubcategory;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    allSubcategories = Tag.getSubCategories(widget.primaryCategory);
    if (widget.selectedSubcategory != null) {
      selectedSubcategory = widget.selectedSubcategory;
      selectedIndex = allSubcategories.indexOf(selectedSubcategory);
    }
  }

  @override
  void didUpdateWidget(covariant NewSubcategoryTagPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    allSubcategories = Tag.getSubCategories(widget.primaryCategory);
    selectedSubcategory = null;
    selectedIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8),
      const Text(
        "하위 카테고리",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: List.generate(allSubcategories.length, (index) {
          return ChoiceChip(
            showCheckmark: false,
            backgroundColor: const Color(0xffF9F9F9),
            selectedColor: const Color(0xffFFF0F0),
            label: Text(allSubcategories[index]),
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
                selectedIndex = selected ? index : null;
                selectedSubcategory = selected ? allSubcategories[index] : null;
                widget.setSelectedInfoValue('subcategory', selectedSubcategory);
              });
            },
          );
        }),
      ),
      const SizedBox(height: 8),
    ]);
  }
}

class NewColorTagPicker extends StatefulWidget {
  const NewColorTagPicker(
      {super.key, required this.setSelectedInfoValue, this.selectedColors});

  final Function setSelectedInfoValue;

  final Set<String>? selectedColors;

  @override
  State<NewColorTagPicker> createState() => _NewColorTagPickerState();
}

class _NewColorTagPickerState extends State<NewColorTagPicker> {
  late List allColors;
  late Set<String> selectedColors;

  @override
  void initState() {
    super.initState();
    allColors = Tag.getColorList();
    if (widget.selectedColors != null) {
      selectedColors = widget.selectedColors!;
    } else {
      selectedColors = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8),
      const Text(
        "색상",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: List.generate(allColors.length, (index) {
          return FilterChip(
            showCheckmark: false,
            backgroundColor: const Color(0xffF9F9F9),
            selectedColor: const Color(0xffFFF0F0),
            avatar: allColors[index][1] == Colors.white
                ? CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xffD9D9D9),
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: allColors[index][1],
                    ),
                  )
                : CircleAvatar(
                    radius: 30,
                    backgroundColor: allColors[index][1],
                  ),
            label: Text(allColors[index][0]),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: selectedColors.contains(allColors[index][0])
                  ? const Color(0xffF6747E)
                  : Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                color: selectedColors.contains(allColors[index][0])
                    ? const Color(0xffF6747E)
                    : const Color(0xffCACACA),
              ),
            ),
            selected: selectedColors.contains(allColors[index][0]),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  selectedColors.add(allColors[index][0]);
                } else {
                  selectedColors.remove(allColors[index][0]);
                }
                widget.setSelectedInfoValue('colors', selectedColors.toList());
              });
            },
          );
        }),
      ),
      const SizedBox(height: 8),
    ]);
  }
}

class NewDetailTagPicker extends StatefulWidget {
  const NewDetailTagPicker(
      {super.key, required this.setSelectedInfoValue, this.selectedDetailTags});

  final Function setSelectedInfoValue;

  final Set<String>? selectedDetailTags;

  @override
  State<NewDetailTagPicker> createState() => _NewDetailTagPickerState();
}

class _NewDetailTagPickerState extends State<NewDetailTagPicker> {
  late List allDetailTags;
  late Set<String> selectedDetailTags;

  @override
  void initState() {
    super.initState();
    allDetailTags = Tag.getDetailTags();
    if (widget.selectedDetailTags != null) {
      selectedDetailTags = widget.selectedDetailTags!;
    } else {
      selectedDetailTags = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8),
      const Row(
        children: [
          Text(
            "세부 태그",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "브랜드, 패턴, 기장, 소재 등",
            style: TextStyle(fontSize: 13, color: Color(0xff777777)),
          )
        ],
      ),
      const SizedBox(height: 8),
      // TODO: 세부 태그 검색 기능
      SizedBox(
        height: 35,
        child: SearchBar(
          leading: SizedBox(child: Image.asset(IconPath.searchBar)),
          backgroundColor: const MaterialStatePropertyAll(Color(0xffF0F0F0)),
          elevation: const MaterialStatePropertyAll(0),
          hintText: "검색",
          hintStyle: MaterialStateProperty.all(const TextStyle(
              color: Color(0xffBDBDBD), fontWeight: FontWeight.w600)),
        ),
      ),
      const SizedBox(height: 5),
      Wrap(
        spacing: 8,
        children: List.generate(allDetailTags.length, (index) {
          return FilterChip(
            showCheckmark: false,
            backgroundColor: const Color(0xffF9F9F9),
            selectedColor: const Color(0xffFFF0F0),
            label: Text(allDetailTags[index]),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: selectedDetailTags.contains(allDetailTags[index])
                  ? const Color(0xffF6747E)
                  : Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                color: selectedDetailTags.contains(allDetailTags[index])
                    ? const Color(0xffF6747E)
                    : const Color(0xffCACACA),
              ),
            ),
            selected: selectedDetailTags.contains(allDetailTags[index]),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  selectedDetailTags.add(allDetailTags[index]);
                } else {
                  selectedDetailTags.remove(allDetailTags[index]);
                }
                widget.setSelectedInfoValue(
                    'tags', selectedDetailTags.toList());
              });
            },
          );
        }),
      ),
      const SizedBox(height: 8),
    ]);
  }
}

class NewStyleTagPicker extends StatefulWidget {
  const NewStyleTagPicker({
    super.key,
    required this.setSelectedInfoValue,
    this.selectedStyles,
  });

  final Function setSelectedInfoValue;

  final Set<String>? selectedStyles;

  @override
  State<NewStyleTagPicker> createState() => _NewStyleTagPickerState();
}

class _NewStyleTagPickerState extends State<NewStyleTagPicker> {
  late List allStyleTags;
  late Set<String> selectedStyleTags;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    allStyleTags = Tag.getStyleTags();
    if (widget.selectedStyles != null) {
      selectedStyleTags = widget.selectedStyles!;
    } else {
      selectedStyleTags = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.transparent),
        const Text(
          "스타일",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(allStyleTags.length, (index) {
            return FilterChip(
              showCheckmark: false,
              backgroundColor: const Color(0xffF9F9F9),
              selectedColor: const Color(0xffFFF0F0),
              label: Text(allStyleTags[index]),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: selectedStyleTags.contains(allStyleTags[index])
                    ? const Color(0xffF6747E)
                    : Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(
                  color: selectedStyleTags.contains(allStyleTags[index])
                      ? const Color(0xffF6747E)
                      : const Color(0xffCACACA),
                ),
              ),
              selected: selectedStyleTags.contains(allStyleTags[index]),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedStyleTags.add(allStyleTags[index]);
                  } else {
                    selectedStyleTags.remove(allStyleTags[index]);
                  }
                  widget.setSelectedInfoValue(
                      'style', selectedStyleTags.toList());
                });
              },
            );
          }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
