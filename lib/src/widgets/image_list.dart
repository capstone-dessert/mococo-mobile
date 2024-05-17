import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/jsons.dart';

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
  final List<Clothes> clothesList = [];
  int? itemCount;

  @override
  void initState() {
    super.initState();
    _loadClothesData();
    itemCount = clothesList.length;
  }

  void _loadClothesData() {
    for (var json in clothesJson['list']) {
      clothesList.add(Clothes.fromJson(json));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: clothesList.length,
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
              _navigateToClothesDetail(context, clothesList[index]);
            }
            // 단일 선택 and 코디 기록 페이지일 때 의류 이미지 배치
            else if (!widget.isMultiClothesSelected! && widget.state == "codi") {
              widget.onClothesSelected?.call();
              setState(() {
                _toggleSelectedIndex(index);
              });
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
              _buildClothesImage(clothesList[index]),
              if (widget.selectedClothesIndices?.contains(index) == true) // 선택된 의류 체크박스로 표시
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

  Widget _buildClothesImage(Clothes clothes) {
    return Image.asset(
      clothes.image,
    );
  }

  void _navigateToClothesDetail(BuildContext context, Clothes cloth) {
    if (cloth.id >= 0 && cloth.id < clothesList.length) {
      widget.onClothesDetail?.call(context, cloth);
    }
  }

  void _toggleSelectedIndex(int index) {
    if (widget.selectedClothesIndices?.contains(index) == true) {
      widget.selectedClothesIndices?.remove(index);
    } else {
      widget.selectedClothesIndices?.add(index);
    }
  }

}
