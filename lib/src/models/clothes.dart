import 'dart:typed_data';

class Clothes {
  final int id;
  final Uint8List image;
  final String primaryCategory;
  final String subCategory;
  final Set styles;
  final Set colors;
  final Set detailTags;
  // final int wearCount;
  // final String? lastWornDate;

  const Clothes({
    required this.id,
    required this.image,
    required this.primaryCategory,
    required this.subCategory,
    required this.colors,
    required this.detailTags,
    required this.styles,
    // required this.wearCount,
    // required this.lastWornDate,
  });

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['id'] as int,
      image: json['image'],
      primaryCategory: json['category'] as String,
      subCategory: json['subcategory'] as String,
      styles: json['styles'].toSet(),
      colors: json['colors'].toSet(),
      detailTags: json['tags'].toSet(),
      // wearCount: json['wearCount'] as int,
      // lastWornDate: json['wearCount'] == 0 ? null : json['lastWornDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'category': primaryCategory,
        'subcategory': subCategory,
        'styles': styles,
        'colors': colors,
        'tags': detailTags,
        // 'wearCount': wearCount,
        // 'lastWornDate': lastWornDate,
      };
}
