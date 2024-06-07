import 'package:flutter/material.dart';

class Tag {
  static Map categories = {
    "상의": [
      "반소매 티셔츠",
      "긴소매 티셔츠",
      "민소매 티셔츠",
      "맨투맨",
      "셔츠/블라우스",
      "후드 티셔츠",
      "니트",
      "스포츠 상의",
      "기타 상의"
    ],
    "하의": ["청바지", "슬랙스", "치마"],
    "아우터": ["자켓", "코트", "점퍼"],
    "원피스": ["미니 원피스", "맥시 원피스", "플레어 원피스"],
    "신발": ["운동화", "구두", "샌들"],
    "모자": ["야구 모자", "비니", "페도라"],
    "가방": ["백팩", "숄더백", "클러치"],
    "악세사리": ["귀걸이", "목걸이", "반지"],
  };

  static List getPrimaryCategories() {
    return categories.keys.toList();
  }

  static List<String> getSubCategories(primaryCategory) {
    return categories[primaryCategory];
  }

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

  static List detailTags = ["브랜드", "패턴", "기장", "소매"];

  static List getDetailTags() {
    return detailTags;
  }

  static List styles = ["댄디", "포멀", "페미닌", "캐주얼", "스트릿", "스포티"];

  static List getStyles() {
    return styles;
  }
}
