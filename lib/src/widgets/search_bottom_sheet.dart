import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/data/image_data.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/pages/closet/p_search.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'clothes_grid_view.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({
    super.key,
    required this.sheetPosition,
    required this.setSelectedStatus,
    required this.setSelectedClothesIndices
  });

  final double sheetPosition;
  final Function(bool) setSelectedStatus;
  final Function(List<int>) setSelectedClothesIndices;

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {

  late ClothesList clothesList;
  bool isLoading = true;
  late double _sheetPosition = 0.20;

  List<int> selectedClothesIndices = [];
  List queries = ["전체"];
  final double _dragSensitivity = 600;
  bool isClothesSelected = false; // 단일 선택 상태
  // bool isMultiClothesSelected = false; // 다중 선택 상태

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
        _sheetPosition = widget.sheetPosition;
      });
    });
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
                offset: const Offset(0, -0.1),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Grabber(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    setState(() {
                      _sheetPosition -= details.delta.dy / _dragSensitivity;
                      if (_sheetPosition < 0.11) {
                        _sheetPosition = 0.11;
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
                        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 8),
                        child: Row(
                          children: List.generate(
                            queries.length,
                            (index) {
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
                            }
                          ) + [
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: OutlinedButton(
                                onPressed: () async {
                                  var result = await Get.to(() => const SearchClothes());
                                  setState(() {
                                    queries = result['newQueries'];
                                    clothesList = result['clothesList'];
                                  });
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
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.black12))
                      : ClothesGridPicker(
                    getClothesList: getClothesList,
                    onClothesSelected: _onClothesSelected,
                    selectedClothesIndices: selectedClothesIndices
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ClothesList getClothesList() {
    return clothesList;
  }

  void _onClothesSelected() {
    setState(() {
      isClothesSelected = true;
    });
    // 상태를 부모 위젯으로 전달
    widget.setSelectedStatus(true);
    widget.setSelectedClothesIndices(selectedClothesIndices);
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
