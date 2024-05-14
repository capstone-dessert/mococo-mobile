import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import '../clothes.dart';

class GridviewPage extends StatefulWidget {
  const GridviewPage({
    Key? key,
    this.onClothesDetail,
    this.onLeftLogoAppBar,
    this.selectedClothesIndices,
    this.toggleSelectableState,
    this.isClothesSelected,
    this.itemCount,
  }) : super(key: key);

  final Function(BuildContext context, Clothes cloth)? onClothesDetail;
  final Function(bool isLeftLogoAppBar)? onLeftLogoAppBar;
  final bool? isClothesSelected;
  final List<int>? selectedClothesIndices;
  final VoidCallback? toggleSelectableState;
  final int? itemCount;

  @override
  GridviewPageState createState() => GridviewPageState();
}

class GridviewPageState extends State<GridviewPage> {
  int? longPressedIndex;

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
            if (widget.isClothesSelected != true) {
              _navigateToClothesDetail(context, index);
            } else {
              widget.toggleSelectableState?.call();
              _toggleSelectedIndex(index);
            }
          },
          onLongPress: () {
            widget.toggleSelectableState?.call();
            setState(() {
              longPressedIndex = index;
              _toggleSelectedIndex(index);
            });
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

  void _toggleSelectedIndex(int index) {
    if (widget.selectedClothesIndices?.contains(index) == true) {
      widget.selectedClothesIndices?.remove(index);
    } else {
      widget.selectedClothesIndices?.add(index);
    }
  }
}
