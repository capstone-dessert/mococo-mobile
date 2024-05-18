import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/category.dart';
import 'package:mococo_mobile/src/data/color.dart';

class CategoryTag extends StatefulWidget {
  const CategoryTag({super.key, required this.primaryCategory, this.subCategory});

  final String primaryCategory;
  final String? subCategory;

  @override
  State<CategoryTag> createState() => _CategoryTagState();
}

class _CategoryTagState extends State<CategoryTag> {

  late List<String> subCategories;
  late List primaryCategories;

  @override
  void initState() {
    super.initState();
    primaryCategories = Category.getPrimaryCategories();
    subCategories = Category.getSubCategories(widget.primaryCategory);
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
                "카테고리",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (var primaryCategory in primaryCategories)
                if (primaryCategory == widget.primaryCategory)
                  Chip(
                    backgroundColor: const Color(0xffF9F9F9),
                    label: Text(primaryCategory),
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: Color(0xffCACACA)),
                    ),
                  ),
              if (widget.subCategory != null && subCategories.contains(widget.subCategory))
                Chip(
                  backgroundColor: const Color(0xffF9F9F9),
                  label: Text(widget.subCategory!),
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
          ),
        ],
      ),
    );
  }
}


class ColorTags extends StatefulWidget {
  const ColorTags({super.key, required this.colorList});

  final List<String> colorList;

  @override
  State<ColorTags> createState() => _ColorTagsState();
}

class _ColorTagsState extends State<ColorTags> {

  List colors = ColorList.getColorList();

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
                    avatar: colorData[1] == Colors.white
                      ? CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xffD9D9D9),
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: colorData[1],
                        ),
                      )
                      : CircleAvatar(
                        radius: 30,
                        backgroundColor: colorData[1],
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


class DetailTags extends StatefulWidget {
  const DetailTags({super.key, required this.detailTagList});

  final List<String> detailTagList;

  @override
  State<DetailTags> createState() => _DetailTagsState();
}

class _DetailTagsState extends State<DetailTags> {

  late List<String> detailTags;

  @override
  void initState() {
    super.initState();
    detailTags = widget.detailTagList;
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

class ScheduleTags extends StatelessWidget {
  const ScheduleTags({super.key, required this.scheduleList});

  final List<String> scheduleList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: List.generate(
        scheduleList.length,
            (index) {
          return Chip(
            backgroundColor: const Color(0xffF9F9F9),
            label: Text(scheduleList[index]),
            labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Color(0xffCACACA),),
            ),
          );
        }
      )
    );
  }
}
