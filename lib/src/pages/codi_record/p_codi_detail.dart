import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/codi.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';

import '../../components/image_data.dart';

class CodiDetail extends StatefulWidget {
  const CodiDetail({super.key, required this.index});

  final int index;

  @override
  State<CodiDetail> createState() => _CodiDetailState();
}

class _CodiDetailState extends State<CodiDetail> {


  @override
  Widget build(BuildContext context) {
    Map codiItem = Codi.getCodiItemByIndex(widget.index);
    DateTime date = codiItem["date"];
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
                Text(
                  "${date.year.toString()}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                // TODO: 데이터 가져와서 넣기
                SizedBox(width: 24, height: 24, child: Image.asset(IconPath.mococoLogo),),
                const SizedBox(width: 6),
                const Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(
                              text: '24℃',
                              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600)
                          ),
                          TextSpan(
                              text: ' / ',
                              style: TextStyle(color: Color(0xff494949), fontSize: 16, fontWeight: FontWeight.w600)
                          ),
                          TextSpan(
                              text: '11℃',
                              style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600)
                          )
                        ]
                    )
                ),
                const SizedBox(width: 7),
                const Text(
                  "전주시",
                  style: TextStyle(fontSize: 16, color: Color(0xff494949), fontWeight: FontWeight.w600),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onEditButtonPressed() {

  }

  void _onDeleteButtonPressed() {

  }
}
