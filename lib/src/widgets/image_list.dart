import 'package:flutter/material.dart';

class GridviewPage extends StatefulWidget {
  const GridviewPage({super.key});

  @override
  GridviewPageState createState() => GridviewPageState();
}

//목록 그리드로 보기
class GridviewPageState extends State<GridviewPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemCount: 14, //item 개수
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 3 / 4, //item 의 가로 1, 세로 2 의 비율
            mainAxisSpacing: 8, //수평 Padding
            crossAxisSpacing: 8, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            //item 의 반목문 항목 형성
            return Container(
              color: Colors.lightGreen,
              child: Text(' Item : $index'),
            );
          },
        ),
      ),
    );
  }
}

//목록 좌우 슬라이드로 보기
// class Slideview extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
