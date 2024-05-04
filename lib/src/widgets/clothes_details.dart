// CustomChip 위젯 정의
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/image_data.dart';

class CustomChip extends StatelessWidget {
  final String label;

  CustomChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: const Color(0xffF9F9F9),
        label: Text(label),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        side: const BorderSide(
          color: Color(0xffCACACA),
        ));
  }
}

class detailsCatView extends StatefulWidget {
  const detailsCatView({super.key});

  @override
  State<StatefulWidget> createState() => detailsCatViewState();
}

class detailsColorView extends StatefulWidget {
  const detailsColorView({super.key});

  @override
  State<StatefulWidget> createState() => detailsColorViewState();
}

class detailsCatViewState extends State<detailsCatView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              Text(
                "카테고리",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 0),
              child: Row(
                children: [
                  CustomChip(label: "상의"),
                  SizedBox(width: 8), // Add some spacing between the chips
                  Image.asset(IconPath.rightArrow),
                  SizedBox(width: 8),
                  CustomChip(label: "반소매 상의")
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "색상",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 0),
              child: Row(
                children: [
                  CustomChip(label: "색상"),
                  SizedBox(width: 8), // Add some spacing between the chips
                  CustomChip(label: "색상")
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "세부 태그",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 0),
              child: Row(
                children: [
                  CustomChip(label: "세부"),
                  SizedBox(width: 8), // Add some spacing between the chips
                  CustomChip(label: "태그")
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "정보",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "정보",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " |",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " 3회",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "마지막 착용 날짜",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " |",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " 2024",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class detailsColorViewState extends State<detailsCatView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              Text(
                "색상",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 20),
              child: Row(
                children: [
                  CustomChip(label: "블랙"),
                  SizedBox(width: 8), // Add some spacing between the chips
                  SizedBox(width: 8),
                  CustomChip(label: "화이트")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
