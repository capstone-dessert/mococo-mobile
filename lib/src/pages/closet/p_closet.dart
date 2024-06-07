import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mococo_mobile/src/components/image_data.dart';
import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/clothes_grid_view.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/pages/closet/p_clothes_detail.dart';
import 'package:mococo_mobile/src/pages/closet/p_search.dart';


class Closet extends StatefulWidget {
  const Closet({super.key});

  @override
  State<Closet> createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {

  late ClothesList clothesList;
  bool isLoading = true;
  List<int> selectedClothesIndices = [];
  bool isClothesSelected = false; // 단일 선택 상태
  bool isMultiClothesSelected = false; // 다중 선택 상태
  List queries = ["전체"];

  @override
  void initState() {
    super.initState();
    fetchClothesAll().then((value) {
      setState(() {
        clothesList = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMultiClothesSelected
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
        child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black12))
          : Stack(
            children: <Widget>[
              if (!isMultiClothesSelected)
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
                              color: Colors.black,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(
                                color: Color(0xffCACACA)
                              ),
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        );
                      }) + [
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
              Padding(
                padding:
                EdgeInsets.only(
                    top: isMultiClothesSelected ? 0 : 58, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isMultiClothesSelected
                          ? '${selectedClothesIndices.length}개'
                          : '${clothesList.list.length}개',
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 0,
                child: isMultiClothesSelected
                  ? const SizedBox()
                  : TextButton(
                    child: const Text(
                      '선택',
                      style: TextStyle(color: Colors.black87),
                    ),
                    onPressed: () {
                      _onMultiClothesSelected();
                    },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: isMultiClothesSelected ? 24 : 90,
                  right: 6,
                  left: 6
                ),
                child: RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.black26,
                  onRefresh: () async {
                    reloadClothesListData();
                  },
                  child: ClothesGridView(
                    state: "detail",
                    getClothesList: getClothesList,
                    onClothesDetail: _onClothesDetail,
                    onLeftLogoAppBar: _onLeftLogoAppBar,
                    isClothesSelected: isClothesSelected,
                    onClothesSelected: _onClothesSelected,
                    isMultiClothesSelected: isMultiClothesSelected,
                    onMultiClothesSelected: _onMultiClothesSelected,
                    selectedClothesIndices: selectedClothesIndices,
                    clothesList: clothesList,
                  ),
                ),
              ),
            ],
        ),
      )
    );
  }

  ClothesList getClothesList() {
    return clothesList;
  }

  void reloadClothesListData() {
    setState(() {
      isLoading = true;
      fetchClothesAll().then((value) {
        setState(() {
          clothesList = value;
          isLoading = false;
        });
      });
    });
  }

  void _onBackButtonPressed() {
    setState(() {
      isClothesSelected = false;
      isMultiClothesSelected = false;
      selectedClothesIndices.clear();
    });
  }

  Future<void> _onAddButtonPressed(BuildContext context) async {
    GetImageModal.show(context, reloadClothesListData);
  }

  void _onClothesDetail(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClothesDetail(clothesId: id, previousPage: "Closet", reloadListData: reloadClothesListData),
      ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    if (selectedClothesIndices.isNotEmpty) {
      AlertModal.show(
        context,
        message: '${selectedClothesIndices.length}개의 의류를 삭제하시겠습니까?',
        onConfirm: () {
          List<int> selectedClothesIds = [];
          for (var clothesIndices in selectedClothesIndices) {
            selectedClothesIds.add(clothesList.list[clothesIndices].id);
          }
          deleteClothes(selectedClothesIds).then((_) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Closet()));
          });
        },
      );
    }
  }

  void _onLeftLogoAppBar(bool isLeftLogoAppBar) {
    setState(() {
      isMultiClothesSelected = !isLeftLogoAppBar;
    });
  }

  void _onClothesSelected() { // 단일 선택 상태로 변환
    setState(() {
      isClothesSelected = true;
    });
  }

  void _onMultiClothesSelected() { // 다중 선택 상태로 변환
    setState(() {
      isMultiClothesSelected = true;
    });
  }
}
