final Map<String, dynamic> clothesJson = {
  "list": [
    {"id": 0, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정", "화이트"}, "detailTags": {"Detail"}},
    {"id": 1, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 2, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 3, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 4, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 5, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 6, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 7, "image": "assets/images/topSample.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 8, "image": "assets/images/tmp.png", "primaryCategory": "상의", "subCategory": "반소매 티셔츠", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 9, "image": "assets/images/tmp.png", "primaryCategory": "상의", "subCategory": "null", "colors": {"검정"}, "detailTags": {"Detail"}},
    {"id": 10, "image": "assets/images/tmp.png", "primaryCategory": "상의", "subCategory": "null", "colors": {"검정"}, "detailTags": {"Detail"}},
  ]
};

final Map<String, dynamic> codiJson = {
  "list": [
    {"id": 0, "image": "assets/images/topSample.png", "date": "2024-05-05", "location": "전주시", "schedules": {"데이트", "운동"}, "clothes": {1, 2}},
    {"id": 1, "image": "assets/images/topSample.png", "date": "2024-05-04", "location": "서울특별시", "schedules": {"데이트"}, "clothes": {1}},
    {"id": 2, "image": "assets/images/topSample.png", "date": "2024-05-03", "location": "부산광역시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 3, "image": "assets/images/topSample.png", "date": "2024-05-02", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 4, "image": "assets/images/tmp.png", "date": "2024-05-01", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 5, "image": "assets/images/tmp.png", "date": "2024-05-01", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 6, "image": "assets/images/tmp.png", "date": "2024-05-01", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 7, "image": "assets/images/tmp.png", "date": "2024-05-01", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 8, "image": "assets/images/tmp.png", "date": "2024-05-01", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 9, "image": "assets/images/tmp.png", "date": "2024-05-01", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
    {"id": 10, "image": "assets/images/tmp.png", "date": "2024-05-01", "location": "전주시", "schedules": {"데이트"}, "clothes": {1, 2}},
  ]
};

Map<String, dynamic>? getCodiJsonById(int id) {
  for (var item in codiJson["list"]) {
    if (item["id"] == id) {
      return item;
    }
  }
  return null;
}



Map<DateTime, List<int>> getCodiEvents() {
  Map<DateTime, List<int>> events = {};

  for (var item in codiJson["list"]) {
    DateTime date = item['date'] as DateTime;
    int index = item['index'] as int;

    if (!events.containsKey(date)) {
      events[date] = [index];
    } else {
      events[date]!.add(index);
    }
  }
  return events;
}