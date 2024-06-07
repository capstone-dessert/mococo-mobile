import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/category.dart';
import 'package:mococo_mobile/src/data/color.dart';

import '../data/style.dart';
import '../data/tag_data.dart';

class CategoryTag extends StatefulWidget {
  const CategoryTag(
      {super.key, required this.primaryCategory, this.subCategory});

  final String primaryCategory;
  final String? subCategory;

  @override
  State<CategoryTag> createState() => _CategoryTagState();
}

class _CategoryTagState extends State<CategoryTag> {
  @override
  void initState() {
    super.initState();
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
              Chip(
                backgroundColor: const Color(0xffF9F9F9),
                label: Text(widget.primaryCategory),
                labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Color(0xffCACACA)),
                ),
              ),
              if (widget.subCategory != null)
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

  final List colorList;

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

  final List detailTagList;

  @override
  State<DetailTags> createState() => _DetailTagsState();
}

class _DetailTagsState extends State<DetailTags> {
  late List detailTags;

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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
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
  const ScheduleTags({super.key, required this.schedule});

  final String schedule;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, children: [
      Chip(
        backgroundColor: const Color(0xffF9F9F9),
        label: Text(schedule),
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
      )
    ]);
  }
}


class StyleTags extends StatefulWidget {
  const StyleTags({Key? key, required this.styleList}) : super(key: key);

  final List styleList;

  @override
  State<StyleTags> createState() => _StyleTagsState();
}

class _StyleTagsState extends State<StyleTags> {
  @override
  Widget build(BuildContext context) {
    List styles = Tag.getStyleTags();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "스타일",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: List.generate(
              widget.styleList.length,
                  (index) {
                return Chip(
                  backgroundColor: const Color(0xffF9F9F9),
                  label: Text(widget.styleList[index]),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

