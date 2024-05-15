import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'package:mococo_mobile/src/pages/closet/p_search.dart';
import '../../clothes.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/image_list.dart';
import '../../widgets/modal.dart';
import 'p_clothes_detail.dart';

class Closet extends StatefulWidget {
  const Closet({Key? key});

  @override
  _ClosetState createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {
  bool _isClothesSelected = false;
  List<int> _selectedClothesIndices = [];
  List queries = ["전체"];
  int itemCount = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isClothesSelected
          ? TextTitleAppBar(
              title: "의류 선택",
              buttonNum: 1,
              onBackButtonPressed: _onBackButtonPressed,
              onDeleteButtonPressed: () {
                _onDeleteButtonPressed(context);
              },
            )
          : LeftLogoAppBar(onAddButtonPressed: _onAddButtonPressed),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Stack(
          children: <Widget>[
            if (!_isClothesSelected)
              Expanded(
                child: SingleChildScrollView(
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
                            labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Color(0xffCACACA),),
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
              ),
            Padding(
              padding:
                  EdgeInsets.only(top: _isClothesSelected ? 0 : 58, left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isClothesSelected
                        ? '${_selectedClothesIndices.length}개'
                        : '$itemCount개',
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40,
              right: 0,
              child: _isClothesSelected
                  ? const SizedBox()
                  : TextButton(
                      child: const Text(
                        '선택',
                        style: TextStyle(color: Colors.black87),
                      ),
                      onPressed: () {
                        _toggleSelectableState();
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _isClothesSelected ? 24 : 90, right: 6, left: 6),
              child: GridviewPage(
                onClothesDetail: _onClothesDetail,
                onLeftLogoAppBar: _onLeftLogoAppBar,
                isClothesSelected: _isClothesSelected,
                selectedClothesIndices: _selectedClothesIndices,
                toggleSelectableState: _toggleSelectableState,
                itemCount: itemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setQueries(newQueries) {
    setState(() {
      queries.clear();
      queries.addAll(newQueries);
    });
  }

  void _onBackButtonPressed() {
    setState(() {
      _isClothesSelected = false;
      _selectedClothesIndices.clear();
    });
  }

  void _onAddButtonPressed(BuildContext context) {
    GetImageModal.show(context);
  }

  void _onClothesDetail(BuildContext context, Clothes cloth) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClothesDetail(clothes: cloth),
      ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    if (_selectedClothesIndices.isNotEmpty) {
      AlertModal.show(
        context,
        message: '${_selectedClothesIndices.length}개의 의류를 삭제하시겠습니까?',
        onConfirm: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Closet()));
        },
      );
    }
  }

  void _onLeftLogoAppBar(bool isLeftLogoAppBar) {
    setState(() {
      _isClothesSelected = !isLeftLogoAppBar;
    });
  }

  void _toggleSelectableState() {
    setState(() {
      _isClothesSelected = true;
    });
  }
}
