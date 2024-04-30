import 'package:flutter/material.dart';

class CatPicker extends StatefulWidget {
  const CatPicker({super.key});

  @override
  CatPickerState createState() => CatPickerState();
}

//카테고리+서브카테고리 태그 선택 그리드
class CatPickerState extends State<CatPicker> {
  final List<bool> isSelectiedList = List.filled(100, false);
  int selectedIndex = -1;

  List<String> checkList = [
    "상의",
    "하의",
    "아우터",
    "원피스",
    "신발",
    "모자",
    "가방",
    "악세사리",
  ];

  List<List<String>> subCategories = [
    [
      "맨투맨",
      "셔츠/블라우스",
      "후드 티셔츠",
      "니트",
      "긴소매 티셔츠",
      "반소매 티셔츠",
      "민소매 티셔츠",
      "스포츠 상의",
      "기타 상의"
    ],
    ["청바지", "슬랙스", "치마"],
    ["자켓", "코트", "점퍼"],
    ["미니 원피스", "맥시 원피스", "플레어 원피스"],
    ["운동화", "구두", "샌들"],
    ["야구 모자", "비니", "페도라"],
    ["백팩", "숄더백", "클러치"],
    ["귀걸이", "목걸이", "반지"],
  ];

  List<bool> isSubCatSelectedList = List.filled(15, false);

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
                      '카테고리',
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
                            for (int i = 0; i < isSelectiedList.length; i++) {
                              isSelectiedList[i] = i == index;
                            }
                            selectedIndex = index;
                            isSubCatSelectedList = List.filled(
                                subCategories[selectedIndex].length, false);
                          });
                        },
                        child: Chip(
                          label: Text(checkList[index]),
                          labelStyle: TextStyle(
                            color: isSelectiedList[index]
                                ? Colors.pink
                                : Colors.black,
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
              if (selectedIndex != -1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 15, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            '카테고리',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '(중복 선택 가능)',
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
                          subCategories[selectedIndex].length,
                          (index) {
                            return GestureDetector(
                              //중복 선택
                              onTap: () {
                                setState(() {
                                  isSubCatSelectedList[index] =
                                      !isSubCatSelectedList[index];
                                });
                              },

                              //하나만 선택
                              // onTap: () {
                              //   setState(() {
                              //     for (int i = 0;
                              //         i < isSubCatSelectedList.length;
                              //         i++) {
                              //       isSubCatSelectedList[i] = i == index;
                              //     }
                              //   });
                              // },
                              child: Chip(
                                label:
                                    Text(subCategories[selectedIndex][index]),
                                labelStyle: TextStyle(
                                  color: isSubCatSelectedList[index]
                                      ? Colors.pink
                                      : Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    color: isSubCatSelectedList[index]
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
            ],
          ),
        ),
      ),
    );
  }
}

//색상 태그 선택 그리드
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
