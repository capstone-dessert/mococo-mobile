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
  }) : super(key: key);

  final Function(BuildContext context, Cloth cloth) onClothDetail;
  final Function(bool isLeftLogoAppBar) onLeftLogoAppBar;
  final bool isClothSelected;
  final List<int> selectedClothIndices; // 선택 이미지 목록
  final VoidCallback toggleSelectableState;

  @override
  GridviewPageState createState() => GridviewPageState();
}

class GridviewPageState extends State<GridviewPage> {
  int? longPressedIndex; // 길게 눌린 이미지 인덱스

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
          onTap: () {
            if (!widget.isClothSelected) { // 짧게 누른 상태, 상세 조회로 이동
              _navigateToClothDetail(context, index);
            }
          },
          onLongPress: () { // 의류 선택 가능 상태 전환 및 선택한 이미지 추적
            widget.toggleSelectableState();
            setState(() {
              longPressedIndex = index; // 선택한 이미지 인덱스 기억
            });
          },
          onTapDown: (_) {
            if (longPressedIndex != null) { // 길게 눌린 이미지가 있을 때만
              setState(() {
                if (widget.selectedClothIndices.contains(index)) {
                  widget.selectedClothIndices.remove(index); // 이미 체크된 경우 체크 해제
                } else {
                  widget.selectedClothIndices.add(index); // 아닌 경우 체크
                }
              });
            }
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
    if(!widget.selectedClothIndices.contains(index)) {
      widget.onClothDetail(context, Cloth(index: index, name: 'Cloth $index'));
    }
  }
}
