import 'package:flutter/material.dart';

class CatTagviewPage extends StatefulWidget {
  const CatTagviewPage({super.key});

  @override
  CatTagviewPageState createState() => CatTagviewPageState();
}

//카테고리 태그 선택 그리드
class CatTagviewPageState extends State<CatTagviewPage> {
  List<String> buttonTexts = [
    "# 상의",
    "# 하의",
    "# 아우터",
    "# 원피스",
    "# 신발",
    "# 모자",
    "# 가방",
    "# 악세사리",
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
                padding: EdgeInsets.only(left: 6, top: 15, bottom: 10),
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
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // 그리드 뷰의 스크롤 제어
                itemCount: buttonTexts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 5 / 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.black87,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(buttonTexts[index]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//색상 태그 선택 그리드
class ColorTagviewPageState extends State<ColorTagviewPage> {
  List<String> buttonTexts = [
    "# 화이트",
    "# 블랙",
    "# 그레이",
    "# 차콜",
    "# 빨강",
    "# 핑크",
    "# 연핑크",
    "# 네이비",
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
                padding: EdgeInsets.only(left: 6, top: 15, bottom: 10),
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
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: buttonTexts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 5 / 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.black87,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(buttonTexts[index]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorTagviewPage extends StatefulWidget {
  const ColorTagviewPage({super.key});

  @override
  ColorTagviewPageState createState() => ColorTagviewPageState();
}
