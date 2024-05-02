class Category {
  static Map category = {
    "상의": ["맨투맨", "셔츠/블라우스", "후드 티셔츠", "니트", "긴소매 티셔츠",
      "반소매 티셔츠", "민소매 티셔츠", "스포츠 상의", "기타 상의"],
    "하의": ["청바지", "슬랙스", "치마"],
    "아우터": ["자켓", "코트", "점퍼"],
    "원피스": ["미니 원피스", "맥시 원피스", "플레어 원피스"],
    "신발": ["운동화", "구두", "샌들"],
    "모자": ["야구 모자", "비니", "페도라"],
    "가방": ["백팩", "숄더백", "클러치"],
    "악세사리": ["귀걸이", "목걸이", "반지"],
  };

  static List getPrimaryCategory() {
    return category.keys.toList();
  }

  static List<String> getSubCategory(primaryCategory) {
    return category[primaryCategory];
  }
}
