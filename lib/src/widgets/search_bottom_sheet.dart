import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'package:mococo_mobile/src/models/clothes.dart';
import 'package:mococo_mobile/src/pages/closet/p_search.dart';
import 'package:mococo_mobile/src/pages/closet/p_clothes_detail.dart';
import 'package:mococo_mobile/src/jsons.dart';
import 'clothes_grid_view.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({Key? key, required this.sheetPosition, required this.setSelectedStatus, required this.setSelectedClothesIndices}) : super(key: key);

  final double sheetPosition;
  final Function(bool) setSelectedStatus;
  final Function(List<int>) setSelectedClothesIndices;

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState(sheetPosition);
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final List<Clothes> clothesList = [];
  List<int> selectedClothesIndices = [];
  int? itemCount;
  List queries = ["전체"];
  double _sheetPosition;
  final double _dragSensitivity = 600;
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태


  _SearchBottomSheetState(this._sheetPosition);

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
    return DraggableScrollableSheet(
      initialChildSize: _sheetPosition,
      minChildSize: 0.1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, -0.1),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Grabber(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    setState(() {
                      _sheetPosition -= details.delta.dy / _dragSensitivity;
                      if (_sheetPosition < 0.18) {
                        _sheetPosition = 0.18;
                      }
                      if (_sheetPosition > 1.0) {
                        _sheetPosition = 1.0;
                      }
                    });
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, left: 8),
                        child: Row(
                          children: List.generate(queries.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Chip(
                                backgroundColor: const Color(0xffF9F9F9),
                                label: Text(queries[index]),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                    color: Color(0xffCACACA),
                                  ),
                                ),
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                              ),
                            );
                          }) + [
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: OutlinedButton(
                                onPressed: () async {
                                  var newQueries = await Get.to(() => const SearchClothes(), arguments: queries.toSet());
                                  if (newQueries == [] || newQueries == null) {
                                    setQueries(["전체"]);
                                  } else {
                                    setQueries(newQueries);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xffF9F9F9),
                                  side: const BorderSide(
                                    color: Color(0xffF6747E),
                                    width: 1.5,
                                  ),
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Image.asset(IconPath.searchTag, width: 20,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 16),
                      child: Row(
                        children: [
                          Text('$itemCount개'),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ClothesGridView(
                    state: "codi",
                    onClothesDetail: _onClothesDetail,
                    isClothesSelected: isClothesSelected,
                    onClothesSelected: _onClothesSelected,
                    isMultiClothesSelected: isMultiClothesSelected,
                    onMultiClothesSelected: _onMultiClothesSelected,
                    selectedClothesIndices: selectedClothesIndices,
                    itemCount: itemCount,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setQueries(newQueries) {
    setState(() {
      queries.clear();
      queries.addAll(newQueries);
    });
  }

  void _onClothesSelected() {
    setState(() {
      isClothesSelected = true;
    });
    // 상태를 부모 위젯으로 전달
    widget.setSelectedStatus(true);
    widget.setSelectedClothesIndices(selectedClothesIndices);
  }


  void _onMultiClothesSelected() { // 다중 선택 상태로 변환
    setState(() {
      isMultiClothesSelected = true;
    });
  }

  void _onClothesDetail(BuildContext context, Clothes cloth) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClothesDetail(clothesId: cloth.id,),
      ),
    );
  }
}


class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.onVerticalDragUpdate,
  });

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: Container(
        width: double.infinity,
        height: 12,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 70.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
