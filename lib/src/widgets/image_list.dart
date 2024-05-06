import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import '../clothes.dart';

class GridviewPage extends StatefulWidget {
  const GridviewPage({
    Key? key,
    required this.onClothesDetail,
    required this.onLeftLogoAppBar,
    required this.selectedClothesIndices,
    required this.toggleSelectableState,
    required this.isClothesSelected,
    required this.itemCount,
  }) : super(key: key);

  final Function(BuildContext context, Clothes cloth) onClothesDetail;
  final Function(bool isLeftLogoAppBar) onLeftLogoAppBar;
  final bool isClothesSelected;
  final List<int> selectedClothesIndices;
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
            if (!widget.isClothesSelected) {
              _navigateToClothesDetail(context, index);
            }
            else {
              widget.toggleSelectableState();
              if (widget.selectedClothesIndices.contains(index)) {
                widget.selectedClothesIndices.remove(index);
              } else {
                widget.selectedClothesIndices.add(index);
              }
            }
          },
          onLongPress: () { // 의류 삭제 페이지 이동
            widget.toggleSelectableState();
            longPressedIndex = index;
            widget.selectedClothesIndices.add(index); // 길게 누른 이미지 기본 체크
          },
          child: Stack(
            children: [
              _buildClothesImage(index),
              if (widget.selectedClothesIndices.contains(index))
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

  Widget _buildClothesImage(int index) {
    return Image.asset(
      IconPath.topSample,
    );
  }

  void _navigateToClothesDetail(BuildContext context, int index) {
    if (!widget.selectedClothesIndices.contains(index)) {
      widget.onClothesDetail(
        context,
        Clothes(index: index, imagePath: IconPath.topSample),
      );
    }
  }
}

