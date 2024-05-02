import 'package:flutter/material.dart';
import '../cloth.dart';

class GridviewPage extends StatefulWidget {
  const GridviewPage({
    Key? key,
    required this.onClothDetail,
    required this.onLeftLogoAppBar,
    required this.isClothSelected,
    required this.toggleSelectableState,
  }) : super(key: key);

  final Function(BuildContext context, Cloth cloth) onClothDetail;
  final Function(bool isLeftLogoAppBar) onLeftLogoAppBar;
  final bool isClothSelected;
  final VoidCallback toggleSelectableState;

  @override
  GridviewPageState createState() => GridviewPageState();
}

class GridviewPageState extends State<GridviewPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 14,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () { // 의류 상세 페이지 이동
            _navigateToClothDetail(context, index);
          },
          onLongPress: () { // 의류 삭제 페이지 이동
            widget.toggleSelectableState();
          },
          child: Container(
            color: widget.isClothSelected ? Colors.blue.withOpacity(0.5) : Colors.lightGreen,
            child: Text(' Item : $index'),
          ),
        );
      },
    );
  }

  void _navigateToClothDetail(BuildContext context, int index) {
    if(!widget.isClothSelected) {
      widget.onClothDetail(context, Cloth(index: index, name: 'Cloth $index'));
    }
  }
}
