// style이 같으면 10점, 그 외인 경우 5점 -> 최종 점수에 따라 나올 확률이 높아짐

//casual - casual, street, dandy, sporty, feminine
//street - street, casual, sporty
//dandy - dandy, casual, formal
//sporty - sporty, casual, street
//feminine - feminine, casual
//formal - formal, dandy

//약속 종류
//간단 외출, 등교, 발표, 데이터, 출근, 면접, 운동, 파티, 결혼식

//날씨 고려 필터링
//최저 23 이상 -> 아우터 제외
//최저 15 이상 -> 후드티, 맨투맨, 니트 제외
//최고 23 이하 -> 민소매 제외
//최고 10 이하 -> 반팔 제외
//최고 10~23 사이일 때 상의에서 반팔 추천 시 아우터 필수 포함

//약속 세부 카테고리 필터링
//결혼식, 면접, 출근 - 민소매, 후드티, 맨투맨, 반바지 제외
//발표 - 민소매, 후드티, 반바지 제외
//운동 - 셔츠/블라우스, 니트, 슬랙스, 치마, 원피스 제외

//부모 아이템, 자식 아이템 1차 선택
//필터링 이후, 남은 의류 아이템 중 상/하의 중 랜덤으로 부모 아이템 선택
//부모 아이템 스타일 연관성 고려하여 자식 아이템 1차 선택

//자식 아이템 2차 선택
//부모 아이템의 색상 고려하여 2차 자식 아이템 선택
//색상 가중치 정의
//1. 부모 블랙 -> 모든 자식 아이템 허용(별도의 가중치 설정 x)
//2. 부모 화이트 -> 하의/화이트는 가중치 0으로 설정
//3. 부모 자식 보색 -> 가중치 0
//4. 부모와 같은 색상(블랙 제외) -> 가중치 0

//색상 점수 매긴 후 상위 3개 중 랜덤으로 선택
//아우터가 존재하면 상의 -> 하의 순으로 고려

//부모 아이템과 색상 점수 매긴 후 상위 3개 중 랜덤으로 선택된 자식 아이템 코디 아이템에 추가 후 사용자에게 반환

//스타일 정의 알고리즘

import 'dart:math';

class ClothingItem {
  String subcategory;
  String category;
  String style;
  String color;

  ClothingItem(this.subcategory, this.category, this.style, this.color);
}

// 옷을 가져와야하는데..
List<ClothingItem> clothingItems = [
  ClothingItem("T-Shirt", "top", "casual", "white"),
  ClothingItem("Jeans", "bottom", "casual", "blue"),
  ClothingItem("Suit Jacket", "outer", "formal", "black"),
  ClothingItem("Dress Shirt", "top", "formal", "white"),
  ClothingItem("Sweatpants", "bottom", "sporty", "gray"),
  ClothingItem("Hoodie", "top", "sporty", "black"),
  ClothingItem("Skirt", "bottom", "feminine", "pink"),
  ClothingItem("Blouse", "top", "feminine", "white"),
  ClothingItem("Shorts", "bottom", "casual", "blue"),
  ClothingItem("Blazer", "outer", "dandy", "navy"),
];

Map<String, int> styleScores = {
  "casual": 0,
  "street": 0,
  "dandy": 0,
  "formal": 0,
  "sporty": 0,
  "feminine": 0,
};

Map<String, List<String>> styleCompatibility = {
  "casual": ["casual", "street", "dandy", "sporty", "feminine"],
  "street": ["street", "casual", "sporty"],
  "dandy": ["dandy", "casual", "formal"],
  "sporty": ["sporty", "casual", "street"],
  "feminine": ["feminine", "casual"],
  "formal": ["formal", "dandy"],
};

void filterByWeather(List<ClothingItem> items, int minTemp, int maxTemp) {
  if (minTemp >= 23) {
    items.removeWhere((item) => item.category == "outer");
  }
  if (minTemp >= 15) {
    items.removeWhere(
        (item) => ["hoodie", "sweater", "knit"].contains(item.subcategory));
  }
  if (maxTemp <= 23) {
    items.removeWhere((item) => item.subcategory == "tank top");
  }
  if (maxTemp <= 10) {
    items.removeWhere(
        (item) => item.category == "top" && item.subcategory == "short sleeve");
  }
}

void filterByOccasion(List<ClothingItem> items, String occasion) {
  if (["marry", "interview", "office"].contains(occasion)) {
    items.removeWhere((item) =>
        ["tank top", "hoodie", "sweater", "shorts"].contains(item.subcategory));
  } else if (occasion == "presentation") {
    items.removeWhere(
        (item) => ["tank top", "hoodie", "shorts"].contains(item.subcategory));
  } else if (occasion == "exercise") {
    items.removeWhere((item) => [
          "shirt",
          "blouse",
          "knit",
          "slacks",
          "skirt",
          "dress"
        ].contains(item.subcategory));
  }
}

List<ClothingItem> selectOutfit(String occasion, int minTemp, int maxTemp) {
  List<ClothingItem> filteredItems = List.from(clothingItems);

  // filterByWeather(filteredItems, minTemp, maxTemp);
  filterByOccasion(filteredItems, occasion);

  ClothingItem parentItem =
      filteredItems[Random().nextInt(filteredItems.length)];

  List<ClothingItem> compatibleItems = filteredItems.where((item) {
    return styleCompatibility[parentItem.style]?.contains(item.style) ?? false;
  }).toList();

  ClothingItem childItem;
  if (compatibleItems.isNotEmpty) {
    childItem = compatibleItems[Random().nextInt(compatibleItems.length)];
  } else {
    childItem = filteredItems[Random().nextInt(filteredItems.length)];
  }

  return [parentItem, childItem];
}

void main() {
  String occasion = "marry";
  int minTemp = 20;
  int maxTemp = 25;

  List<ClothingItem> outfit = selectOutfit(occasion, minTemp, maxTemp);

  print("Recommended Outfit:");
  outfit.forEach((item) {
    print(
        "${item.category}: ${item.subcategory} (${item.style}, ${item.color}),$styleScores");
  });
}
