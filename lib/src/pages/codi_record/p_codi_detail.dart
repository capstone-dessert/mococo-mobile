import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/pages/closet/p_clothes_detail.dart';
import 'package:mococo_mobile/src/service/http_service.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/tags.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_edit_codi_record.dart';

class CodiDetail extends StatefulWidget {
  const CodiDetail({
    super.key,
    required this.codiId,
    required this.reloadCodiListData
  });

  final int codiId;

  final Function reloadCodiListData;

  @override
  State<CodiDetail> createState() => _CodiDetailState();
}

class _CodiDetailState extends State<CodiDetail> {

  DateTime selectedDate = DateTime.now();
  late Codi codi;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCodi(widget.codiId).then((value) {
      setState(() {
        codi = value;
        isLoading = false;
      });
    });
  }

  void onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "코디 상세 정보",
        buttonNum: 2,
        onBackButtonPressed: _onBackButtonPressed,
        onEditButtonPressed: _onEditButtonPressed,
        onDeleteButtonPressed: _onDeleteButtonPressed,
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.black12))
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 6),
                  DateWidget(
                    isCenter: false,
                    isEditable: false,
                    date: codi.date,
                    onDateChanged: onDateChanged,
                  ),
                  const Spacer(),
                  WeatherWidget(isSmall: true, isEditable: false, date: codi.date, weather: codi.weather),
                  const SizedBox(width: 4),
                ],
              ),
              const SizedBox(height: 6),
              // TODO: 코디 사진
              SizedBox(
                height: 370,
                child: Image.asset(codi.image),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ScheduleTags(schedule: codi.schedule)
              ),
              const Divider(color: Color(0xffF0F0F0),),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      codi.clothes.list.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClothesDetail(
                                    clothesId: codi.clothes.list[index].id,
                                    previousPage: "CodiDetail",
                                    reloadListData: widget.reloadCodiListData
                                  )
                                )
                              );
                            },
                            child: Image.memory(codi.clothes.list[index].image)
                          ),
                        );
                      }
                    )
                  ),
                ),
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(color: Colors.black12),
            ),
          ),
        );
      },
    );
  }


  void reloadCodiData() {
    setState(() {
      isLoading = true;
      fetchCodi(widget.codiId).then((value) {
        setState(() {
          codi = value;
          isLoading = false;
        });
      });
    });
    widget.reloadCodiListData();
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onEditButtonPressed() {
    if (!isLoading) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditCodiRecord(codiItem: codi, reloadCodiData: reloadCodiData)
        )
      );
    }
  }

  void _onDeleteButtonPressed() {
    if (!isLoading) {
      AlertModal.show(
        context,
        message: '코디를 삭제하시겠습니까?',
        onConfirm: () {
          _showLoadingDialog(context);
          deleteCodi(codi.id).then((_) {
            widget.reloadCodiListData();
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pop(context);
          });
        },
      );
    }
  }
}
