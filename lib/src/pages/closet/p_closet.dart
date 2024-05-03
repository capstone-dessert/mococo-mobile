import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'package:mococo_mobile/src/pages/closet/p_regist_cloth.dart';
import 'package:mococo_mobile/src/pages/closet/p_search.dart';
import 'package:mococo_mobile/src/widgets/alert_modal.dart';
import '../../cloth.dart';
import '../../widgets/get_image_modal.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/image_list.dart';
import 'p_cloth_detail.dart';

class Closet extends StatefulWidget {
  const Closet({Key? key});

  @override
  _ClosetState createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {
  bool _isClothSelected = false;
  List<int> _selectedClothIndices = [];
  List queries = ["전체"];
  int itemCount = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isClothSelected
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
            if (!_isClothSelected)
              Positioned(
                top: 5,
                left: 6,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                      List.generate(
                        queries.length,
                              (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xffF9F9F9),
                                side: const BorderSide(
                                  color: Color(0xffCACACA),
                                  width: 1.5,
                                ),
                                minimumSize: Size.zero,
                                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 17),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                queries[index],
                                style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
                              ),
                            ),
                          );
                        }
                      ) + [
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: OutlinedButton(
                            onPressed: () async {
                              var newQueries =  await Get.to(() => const SearchClothes(), arguments: queries.toSet());
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
                            child: Image.asset(IconPath.searchTag, width: 20,)
                          ),
                        ),
                      ],
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: _isClothSelected ? 0 : 58, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_isClothSelected ? '${_selectedClothIndices.length}개' : '$itemCount개',),
                  ],
                ),
              ),
            Positioned(
              top: 40,
              right: 0,
              child: _isClothSelected ? SizedBox() : TextButton(
                child: const Text(
                  '선택',
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: _isClothSelected ? 24 : 90, right: 6, left: 6),
              child: GridviewPage(
                onClothDetail: _onClothDetail,
                onLeftLogoAppBar: _onLeftLogoAppBar,
                isClothSelected: _isClothSelected,
                selectedClothIndices: _selectedClothIndices,
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
    queries = newQueries;
  }

  void _onBackButtonPressed() {
    setState(() {
      _isClothSelected = false;
      _selectedClothIndices.clear();
    });
  }

  void _onAddButtonPressed(BuildContext context) {
    GetImageModal.show(context);
  }

  void _onClothDetail(BuildContext context, Cloth cloth) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClothDetail(cloth: cloth),
      ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    if(_selectedClothIndices.length > 0)
      AlertModal.show(context, true, _selectedClothIndices.length);
  }

  void _onLeftLogoAppBar(bool isLeftLogoAppBar) {
    setState(() {
      _isClothSelected = !isLeftLogoAppBar;
    });
  }

  void _toggleSelectableState() {
    setState(() {
      _isClothSelected = true;
    });
  }
}
