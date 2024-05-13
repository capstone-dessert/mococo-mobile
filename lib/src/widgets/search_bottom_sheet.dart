import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'package:mococo_mobile/src/pages/closet/p_search.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key, required this.queries});

  final List queries;

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {

  double _sheetPosition = 0.25;
  final double _dragSensitivity = 600;
  int itemCount = 9; // 아이템 개수 나중에 수정

  @override
  Widget build(BuildContext context) {
    List queries = widget.queries;
    return DraggableScrollableSheet(
        initialChildSize: _sheetPosition,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: Offset(0, -0.1))],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Grabber(
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      setState(() {
                        _sheetPosition -= details.delta.dy / _dragSensitivity;
                        if (_sheetPosition < 0.25) {
                          _sheetPosition = 0.25;
                        }
                        if (_sheetPosition > 1.0) {
                          _sheetPosition = 1.0;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children:
                          List.generate(
                              queries.length,
                                  (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Chip(
                                    backgroundColor: const Color(0xffF9F9F9),
                                    label: Text(queries[index]),
                                    labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: const BorderSide(color: Color(0xffCACACA),),
                                    ),
                                  ),
                                );
                              }
                          ) + [
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: GestureDetector(
                                onTap: () async {
                                  var newQueries =  await Get.to(() => const SearchClothes(), arguments: queries.toSet());
                                  if (newQueries == [] || newQueries == null) {
                                    queries = ["전체"];
                                  } else {
                                    queries = newQueries;
                                  }
                                },
                                child: Chip(
                                  backgroundColor: const Color(0xffFFF0F0),
                                  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                                  label: Image.asset(IconPath.searchTag, width: 20,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: const BorderSide(color: Color(0xffF6747E),),
                                  ),

                                ),
                              ),
                            ),]
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('$itemCount개',),
                              const Spacer()
                            ],
                          ),
                          // TODO: GridviewPage 띄우기
                          // GridviewPage()
                        ],
                      )
                  )
                ],
              ),
            ),
          );
        }
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
        color: Colors.white,
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
