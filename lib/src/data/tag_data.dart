import 'package:flutter/material.dart';

class Tag {
  static Map categories = {
    "상의": ["반소매 티셔츠", "긴소매 티셔츠", "민소매 티셔츠", "맨투맨", "셔츠/블라우스",
      "후드 티셔츠", "니트"],
    "하의": ["청바지", "슬랙스", "반바지", "트레이닝팬츠", "치마", "레깅스"],
    "아우터": ["가디건", "자켓", "코트", "패딩", "점퍼", "무스탕", "조끼"],
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

  static List styleTags = ["댄디", "포멀", "페미닌", "캐주얼", "스트릿", "스포티"];

  static List getStyleTags() {
    return styleTags;
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

  static List detailTags = ["무지", "그래픽", "스트라이프", "브이넥", "오프숄더", "크롭"];

  static List getDetailTags() {
    return List.from(detailTags);
  }

  static void addDetailTags(List newTags) {
    detailTags.addAll(newTags);
  }

  static List scheduleTags = ["간단 외출", "등교", "발표", "데이트", "출근", "면접", "운동", "파티", "결혼식"];

  static List getScheduleTags() {
    return scheduleTags;
  }


  static Map<String, String> classifiedColor = {
    "white": "화이트",
    "black": "블랙",
    "gray": "그레이",
    "silver": "그레이",
    "maroon": "빨강",
    "red": "빨강",
    "fuchsia": "핑크",
    "navy": "네이비",
    "blue": "파랑",
    "purple": "보라",
    "olive": "카키",
    "green": "초록",
    "lime": "초록",
    "teal": "초록",
    "aqua": "민트",
    "yellow": "노랑"
  };
}


