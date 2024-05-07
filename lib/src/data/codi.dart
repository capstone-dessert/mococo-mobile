class Codi {
  static List<Map<String, Object>> codiItems = [
    {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 5)},
    {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 4)},
    {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 3)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 2)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
    {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
  ];

  static int getLengthCodiItems() {
    return codiItems.length;
  }

  static Map<String, Object> getCodiItemByIndex(int index) {
    return codiItems[index];
  }

}