class Codi {
  static List<Map<String, Object>> codiItems = [
    {"index": 0, "image": "assets/images/topSample.png", "date": DateTime(2024, 5, 5), "schedule": ["데이트", "운동"]},
    {"index": 1, "image": "assets/images/topSample.png", "date": DateTime(2024, 5, 4), "schedule": ["데이트"]},
    {"index": 2, "image": "assets/images/topSample.png", "date": DateTime(2024, 5, 3), "schedule": ["데이트"]},
    {"index": 3, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 2), "schedule": ["데이트"]},
    {"index": 4, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"index": 5, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"index": 6, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"index": 7, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"index": 8, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"index": 9, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"index": 10, "image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
  ];

  static int getLengthCodiItems() {
    return codiItems.length;
  }

  static Map<String, Object> getCodiItemByIndex(int index) {
    return codiItems[index];
  }

  static Map<DateTime, List<int>> getCodiEvents() {
    Map<DateTime, List<int>> events = {};

    for (var item in codiItems) {
      DateTime date = item['date'] as DateTime;
      int index = item['index'] as int;

      // 이미 맵에 해당 날짜가 있는지 확인하고, 없다면 새로운 리스트를 만들어 추가
      if (!events.containsKey(date)) {
        events[date] = [index];
      } else {
        events[date]!.add(index);
      }
    }

    return events;
  }
}