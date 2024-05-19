import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/jsons.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/clothes_preview.dart';

class ClothesGridView extends StatefulWidget {
  const ClothesGridView({
    super.key,
    this.state,
    this.onClothesDetail,
    this.onLeftLogoAppBar,
    this.selectedClothesIndices,
    this.isClothesSelected,
    this.onClothesSelected,
    this.isMultiClothesSelected,
    this.onMultiClothesSelected,
    this.itemCount,
  });

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
  ClothesGridViewState createState() => ClothesGridViewState();
}

class ClothesGridViewState extends State<ClothesGridView> {
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
              Center(child: _buildClothesImage(clothesList[index])),
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


class ClothesGridPicker extends StatefulWidget {
  const ClothesGridPicker({super.key, required this.clothesList, this.selectedClothesIndices, this.onClothesSelected});

  final ClothesList clothesList;
  final List<int>? selectedClothesIndices;
  final VoidCallback? onClothesSelected;

  @override
  State<ClothesGridPicker> createState() => _ClothesGridPickerState();
}

class _ClothesGridPickerState extends State<ClothesGridPicker> {

  late ClothesList clothesList;

  @override
  void initState() {
    super.initState();
    clothesList = widget.clothesList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${clothesList.list!.length}개',
                style: const TextStyle(color: Color(0xff888888)),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            itemCount: clothesList.list!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (BuildContext context, int index) {
              ClothesPreview codiItem = clothesList.list![index];
              return GestureDetector(
                onTap: () {
                  widget.onClothesSelected?.call();
                  setState(() {
                    _toggleSelectedIndex(index);
                  });
                },
                child: Stack(
                  children: [
                    Center(child: Image.asset(codiItem.image)),
                    // 선택된 의류 체크박스로 표시
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
          ),
        ],
      ),
    );
  }

  void _toggleSelectedIndex(int index) {
    if (widget.selectedClothesIndices?.contains(index) == true) {
      widget.selectedClothesIndices?.remove(index);
    } else {
      widget.selectedClothesIndices?.add(index);
    }
  }
}