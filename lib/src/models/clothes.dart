import 'dart:io';

class Clothes {
  final int id;
  // TODO: to image Type(File / XFile)
  final String image;
  final String primaryCategory;
  final String subCategory;
  final Set colors;
  final Set detailTags;

  const Clothes({
    required this.id,
    required this.image,
    required this.primaryCategory,
    required this.subCategory,
    required this.colors,
    required this.detailTags
  });

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['id'] as int,
      image: json['image'],
      primaryCategory: json['primaryCategory'] as String,
      subCategory: json['subCategory'] as String,
      colors: json['colors'] as Set,
      detailTags: json['detailTags'] as Set
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'image': image,
      'primaryCategory': primaryCategory,
      'subCategory': subCategory,
      'colors': colors,
      'detailTags': detailTags,
    };
}