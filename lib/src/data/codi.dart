class Codi {
  static List<Map<String, Object>> codiItems = [
    {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 5), "schedule": ["데이트", "운동"]},
    {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 4), "schedule": ["데이트"]},
    {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 3), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 2), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1), "schedule": ["데이트"]},
  ];

  static int getLengthCodiItems() {
    return codiItems.length;
  }

  static Map<String, Object> getCodiItemByIndex(int index) {
    return codiItems[index];
  }

}