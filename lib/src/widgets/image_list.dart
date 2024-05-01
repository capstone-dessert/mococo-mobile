import 'package:flutter/material.dart';
import '../cloth.dart';

class GridviewPage extends StatefulWidget {
  const GridviewPage({Key? key, required this.onClothSelected});
  final Function(BuildContext context, Cloth cloth) onClothSelected;

  @override
  GridviewPageState createState() => GridviewPageState();
}

class GridviewPageState extends State<GridviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 14,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              widget.onClothSelected(context, Cloth(index: index, name: 'Cloth $index'));
            },
            child: Container(
              color: Colors.lightGreen,
              child: Text(' Item : $index'),
            ),
          );
        },
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