import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/clothes_preview.dart';

class ClothesGridView extends StatefulWidget {
  const ClothesGridView({
    super.key,
    this.state,
    required this.getClothesList,
    this.onClothesDetail,
    this.onLeftLogoAppBar,
    this.selectedClothesIds,
    this.isClothesSelected,
    this.onClothesSelected,
    this.isMultiClothesSelected,
    this.onMultiClothesSelected,
    required this.clothesList,
  });

  final String? state;

  final Function getClothesList;
  final Function(BuildContext context, int id)? onClothesDetail;
  final Function(bool isLeftLogoAppBar)? onLeftLogoAppBar;
  final bool? isClothesSelected;
  final bool? isMultiClothesSelected;
  final List<int>? selectedClothesIds;
  final VoidCallback? onClothesSelected;
  final VoidCallback? onMultiClothesSelected;
  final ClothesList clothesList;

  @override
  ClothesGridViewState createState() => ClothesGridViewState();
}

class ClothesGridViewState extends State<ClothesGridView> {

  int? longPressedIndex;
  String? state;
  late ClothesList clothesList;

  @override
  void initState() {
    super.initState();
    clothesList = widget.clothesList;
  }

  @override
  void didUpdateWidget(covariant ClothesGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    clothesList = widget.getClothesList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: clothesList.list.length,
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
              _navigateToClothesDetail(context, clothesList.list[index].id);
            }
            // 단일 선택 and 코디 기록 페이지일 때 의류 이미지 배치
            else if (!widget.isMultiClothesSelected! && widget.state == "codi") {
              widget.onClothesSelected?.call();
              setState(() {
                _toggleSelectedId(clothesList.list[index].id);
              });
            }
            // 다중 선택일 때 체크박스 변경
            else {
              widget.onMultiClothesSelected?.call();
              _toggleSelectedId(clothesList.list[index].id);
            }
          },
          onLongPress: () {
            if(widget.state != "codi") {
              setState(() {
                widget.onMultiClothesSelected?.call();
                longPressedIndex = index;
                _toggleSelectedId(clothesList.list[index].id);
              });
            }
          },
          child: Stack(
            children: [
              Center(child: Image.memory(clothesList.list[index].image)),
              if (widget.selectedClothesIds?.contains(clothesList.list[index].id) == true) // 선택된 의류 체크박스로 표시
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

  void _navigateToClothesDetail(BuildContext context, int id) {
    widget.onClothesDetail?.call(context, id);
  }

  void _toggleSelectedId(int id) {
    if (widget.selectedClothesIds?.contains(id) == true) {
      widget.selectedClothesIds?.remove(id);
    } else {
      widget.selectedClothesIds?.add(id);
    }
  }
}


class ClothesGridPicker extends StatefulWidget {
  const ClothesGridPicker({
    super.key,
    required this.getClothesList,
    this.selectedClothesIds,
    this.onClothesSelected
  });

  final Function getClothesList;

  final List<int>? selectedClothesIds;
  final VoidCallback? onClothesSelected;

  @override
  State<ClothesGridPicker> createState() => _ClothesGridPickerState();
}

class _ClothesGridPickerState extends State<ClothesGridPicker> {

  late ClothesList clothesList;

  @override
  void initState() {
    super.initState();
    clothesList = widget.getClothesList();
  }

  @override
  void didUpdateWidget(covariant ClothesGridPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    clothesList = widget.getClothesList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${clothesList.list.length}개',
                style: const TextStyle(color: Color(0xff888888)),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            itemCount: clothesList.list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (BuildContext context, int index) {
              ClothesPreview codiItem = clothesList.list[index];
              return GestureDetector(
                onTap: () {
                  widget.onClothesSelected?.call();
                  setState(() {
                    _toggleSelectedIndex(clothesList.list[index].id);
                  });
                },
                child: Stack(
                  children: [
                    Center(child: Image.memory(codiItem.image)),
                    // 선택된 의류 체크박스로 표시
                    if (widget.selectedClothesIds?.contains(clothesList.list[index].id) == true)
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

  void _toggleSelectedIndex(int id) {
    if (widget.selectedClothesIds?.contains(id) == true) {
      widget.selectedClothesIds?.remove(id);
    } else {
      widget.selectedClothesIds?.add(id);
    }
  }
}