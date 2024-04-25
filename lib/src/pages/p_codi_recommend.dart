

import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/pages/p_codi_recommend_result.dart';

import '../components/image_data.dart';

class CodiRecommend extends StatefulWidget {
  const CodiRecommend({super.key});

  @override
  State<CodiRecommend> createState() => _CodiRecommendState();
}

class _CodiRecommendState extends State<CodiRecommend> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        elevation: 0,
        centerTitle: true,
        title: SizedBox(width: 140, child: Image.asset(IconPath.logo)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 25,),
                  TextButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
                      if (selectedDate != null) {
                        setState(() {
                          date = selectedDate;
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${date.year.toString()}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
                          style: const TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.underline),
                        ),
                        const SizedBox(width: 3,),
                        SizedBox(width: 22, child: Image.asset(IconPath.editCondition,),)
                      ],
                    )
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Stack(
                children: [
                  Container(
                    width: 345,
                    height: 90,
                    decoration: ShapeDecoration(
                      color: const Color(0xffFFF5F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                  ),
                  Positioned(      // <날씨 아이콘 자리>
                    left: 20,
                    top: 20,
                    child: SizedBox(width: 50, height: 50, child: Image.asset(IconPath.mococoLogo),)
                  ),
                  Positioned(
                    left: 90,
                    top: 18,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "전주시",      // <위치 받아오기>
                            style: TextStyle(fontSize: 18, color: Colors.black, decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 3,),
                          SizedBox(width: 22, child: Image.asset(IconPath.editCondition,),)
                        ],
                      )
                    )
                  ),
                  const Positioned(
                    left: 90,
                    top: 50,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '24℃',
                            style: TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.w500)
                          ),
                          TextSpan(
                            text: ' / ',
                            style: TextStyle(color: Color(0xff494949), fontSize: 17, fontWeight: FontWeight.w500)
                          ),
                          TextSpan(
                            text: '11℃',
                            style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500)
                          )
                        ]
                      )
                    )
                  ),
                  const Positioned(
                    left: 213,
                    top: 49,
                    child: Text(
                      '체감온도 24℃',
                      style: TextStyle(color: Color(0xff494949), fontSize: 17, fontWeight: FontWeight.w500),
                    )
                  )
                ],
              ),
              // <약속 종류 태그>
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: 345,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CodiRecommendResult()));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffF6747E)
                    ),
                    child: const Text(
                      "추천받기",
                      style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
