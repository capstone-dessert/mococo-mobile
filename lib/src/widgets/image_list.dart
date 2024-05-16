import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import '../clothes.dart';

class GridviewPage extends StatefulWidget {
  const GridviewPage({
    Key? key,
    this.state,
    this.onClothesDetail,
    this.onLeftLogoAppBar,
    this.selectedClothesIndices,
    this.isClothesSelected,
    this.onClothesSelected,
    this.isMultiClothesSelected,
    this.onMultiClothesSelected,
    this.itemCount,
  }) : super(key: key);

  final String? state;
  final Function(BuildContext context, Clothes cloth)? onClothesDetail;
  final Function(bool isLeftLogoAppBar)? onLeftLogoAppBar;
  final bool? isClothesSelected;
  final bool? isMultiClothesSelected;
  final List<int>? selectedClothesIndices;
  final VoidCallback? onClothesSelected;
  final VoidCallback? onMultiClothesSelected;
  final int? itemCount;

  @override
  GridviewPageState createState() => GridviewPageState();
}

class GridviewPageState extends State<GridviewPage> {
  int? longPressedIndex;
  String? state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.itemCount ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // 단일 선택 and 옷장 페이지일 때 의류 상세 정보 페이지 이동
            if (!widget.isMultiClothesSelected! && widget.state == "detail") {
              widget.onClothesSelected?.call();
              _navigateToClothesDetail(context, index);
            }
            // 단일 선택 and 코디 기록 페이지일 때 의류 이미지 배치
            else if (!widget.isMultiClothesSelected! && widget.state == "codi") {
              widget.onClothesSelected?.call();
              print("단일 선택 and 코디 기록");
              // TODO 이미지 배치
              _showClothes(context, index);
            }
            // 다중 선택일 때 체크박스 변경
            else {
              widget.onMultiClothesSelected?.call();
              _toggleSelectedIndex(index);
            }
          },
          onLongPress: () {
            if(widget.state != "codi") {
              setState(() {
                widget.onMultiClothesSelected?.call();
                longPressedIndex = index;
                _toggleSelectedIndex(index);
              });
            }
          },
          child: Stack(
            children: [
              _buildClothesImage(index),
              if (widget.selectedClothesIndices?.contains(index) == true)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
                    shape: const CircleBorder(),
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
      IconPath.topSample ?? '',
    );
  }

  void _navigateToClothesDetail(BuildContext context, int index) {
    if (widget.selectedClothesIndices?.contains(index) != true) {
      widget.onClothesDetail?.call(
        context,
        Clothes(index: index, imagePath: IconPath.topSample ?? ''),
      );
    }
  }

  void _showClothes(BuildContext context, int index) {

  }

  void _toggleSelectedIndex(int index) {
    if (widget.selectedClothesIndices?.contains(index) == true) {
      widget.selectedClothesIndices?.remove(index);
    } else {
      widget.selectedClothesIndices?.add(index);
    }
  }

}
