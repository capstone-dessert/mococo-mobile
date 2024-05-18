import 'package:flutter/material.dart';

class ColorList {
  static List colors = [
    ["화이트", Colors.white],
    ["블랙", Colors.black],
    ["그레이", const Color(0xffCDCDCD)],
    ["차콜", const Color(0xff6D6D6D)],
    ["빨강", Colors.red],
    ["핑크", const Color(0xffFF63CA)],
    ["네이비", const Color(0xff002F89)],
    ["파랑", const Color(0xff0057FF)],
    ["하늘", const Color(0xffAFECFF)],
    ["보라", const Color(0xff7D00FA)],
    ["카키", const Color(0xff5C7300)],
    ["초록", Colors.green],
    ["민트", const Color(0xff9BFFCE)],
    ["노랑", Colors.yellow],
    ["주황", Colors.orange],
    ["베이지", const Color(0xffEBDDCC)],
    ["브라운", Colors.brown]
  ];

  static List getColorList() {
    return colors;
  }
}
