import 'package:flutter/material.dart';

class TagviewPage extends StatefulWidget {
  const TagviewPage({super.key});

  @override
  TagviewPageState createState() => TagviewPageState();
}

//목록 그리드로 보기
class TagviewPageState extends State<TagviewPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemCount: 14, //item 개수
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 5 / 2, //item 의 가로 1, 세로 2 의 비율
            mainAxisSpacing: 8, //수평 Padding
            crossAxisSpacing: 15, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            //item 의 반목문 항목 형성
            return Container(
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('#$index'),
              ),
            );
          },
        ),
      ),
    );
  }
}
