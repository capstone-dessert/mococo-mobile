import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import '../cloth.dart';

class GridviewPage extends StatefulWidget {
  const GridviewPage({
    Key? key,
    required this.onClothDetail,
    required this.onLeftLogoAppBar,
    required this.selectedClothIndices,
    required this.toggleSelectableState,
    required this.isClothSelected,
    required this.itemCount,
  }) : super(key: key);

  final Function(BuildContext context, Cloth cloth) onClothDetail;
  final Function(bool isLeftLogoAppBar) onLeftLogoAppBar;
  final bool isClothSelected;
  final List<int> selectedClothIndices;
  final VoidCallback toggleSelectableState;
  final int itemCount;

  @override
  GridviewPageState createState() => GridviewPageState();
}

class GridviewPageState extends State<GridviewPage> {
  int? longPressedIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () { // 의류 상세 페이지 이동
            if (!widget.isClothSelected) {
              _navigateToClothDetail(context, index);
            }
            else {
              widget.toggleSelectableState();
              if (widget.selectedClothIndices.contains(index)) {
                widget.selectedClothIndices.remove(index);
              } else {
                widget.selectedClothIndices.add(index);
              }
            }
          },
          onLongPress: () { // 의류 삭제 페이지 이동
            widget.toggleSelectableState();
            longPressedIndex = index;
            widget.selectedClothIndices.add(index); // 길게 누른 이미지 기본 체크
          },
          child: Stack(
            children: [
              _buildClothImage(index),
              if (widget.selectedClothIndices.contains(index))
                Positioned(
                  top: 5,
                  right: 5,
                  child: Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
                    shape: CircleBorder(),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClothImage(int index) {
    return Image.asset(
      IconPath.topSample,
    );
  }

  void _navigateToClothDetail(BuildContext context, int index) {
    if (!widget.selectedClothIndices.contains(index)) {
      widget.onClothDetail(
          context, Cloth(index: index, name: 'Cloth $index'));
    }
  }
}

