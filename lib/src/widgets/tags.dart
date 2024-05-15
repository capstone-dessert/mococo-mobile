import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/category.dart';

class CategoryTag extends StatefulWidget {
  const CategoryTag({super.key, required this.primaryCategory, this.subCategory});

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
  const ColorTag({super.key, required this.colorList});

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


class DetailTag extends StatefulWidget {
  const DetailTag({super.key, required this.detailList});

  final List<String> detailList;

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