import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/codi.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_codi_record.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_edit_codi_record.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/date.dart';
import 'package:mococo_mobile/src/widgets/modal.dart';
import 'package:mococo_mobile/src/widgets/weather.dart';

import '../../components/image_data.dart';

class CodiDetail extends StatefulWidget {
  const CodiDetail({super.key, required this.index});

  final int index;

  @override
  State<CodiDetail> createState() => _CodiDetailState();
}

class _CodiDetailState extends State<CodiDetail> {

  Map codiItem = {};

  @override
  Widget build(BuildContext context) {
    codiItem = Codi.getCodiItemByIndex(widget.index);
    List<String> schedule = codiItem["schedule"].toList() ?? [];
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "코디 상세 정보",
        buttonNum: 2,
        onBackButtonPressed: _onBackButtonPressed,
        onEditButtonPressed: _onEditButtonPressed,
        onDeleteButtonPressed: _onDeleteButtonPressed,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 6),
                Date(isCenter: false, isEditable: false, date: codiItem["date"],),
                const Spacer(),
                // TODO: 위치, 날씨 데이터 가져와서 넣기
                Weather(isSmall: true, isEditable: false, location: codiItem["location"],),
                const SizedBox(width: 4),
              ],
            ),
            const SizedBox(height: 6),
            // TODO: 코디 사진
            Container(
              height: 370,
              child: Image.asset(codiItem["image"]),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                spacing: 8,
                children: List.generate(
                  schedule.length,
                      (index) {
                    return Chip(
                      backgroundColor: const Color(0xffF9F9F9),
                      label: Text(schedule[index]),
                      labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Color(0xffCACACA),),
                      ),
                    );
                  }
                )
              ),
            ),
            const Divider(color: Color(0xffF0F0F0),),
            const SizedBox(height: 8),
            // TODO: 의류 사진
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(IconPath.topSample,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(color: Colors.black12, width:150,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(color: Colors.black12, width:150,),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onEditButtonPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCodiRecord(codiItem: codiItem)));
  }

  void _onDeleteButtonPressed() {
    AlertModal.show(
      context,
      message: '코디를 삭제하시겠습니까?',
      onConfirm: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CodiRecord()));
      },
    );
  }
}
