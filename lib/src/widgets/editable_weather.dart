import 'package:flutter/material.dart';
import '../components/image_data.dart';

class EditableWeather extends StatefulWidget {
  const EditableWeather({super.key});

  @override
  State<EditableWeather> createState() => _EditableWeatherState();
}

class _EditableWeatherState extends State<EditableWeather> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
            onPressed: () {_showModalBottomSheet();},
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
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      elevation: 0,
      builder: (context) {
        return Container(
          height: 515,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                  child: SearchBar(
                    leading: SizedBox(child: Image.asset(IconPath.searchBar)),
                    backgroundColor: const MaterialStatePropertyAll(Color(0xffF0F0F0)),
                    elevation: const MaterialStatePropertyAll(0),
                    hintText: "검색",
                    hintStyle: MaterialStateProperty.all(const TextStyle(color: Color(0xffBDBDBD), fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 16,),
                // 검색 결과 리스트
              ],
            ),
          ),
        );
      }
    );
  }
}