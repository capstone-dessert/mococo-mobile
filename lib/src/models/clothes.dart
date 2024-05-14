import 'dart:io';

class Clothes {
  final int id;
  // TODO: image Type - File / XFile
  final File image;
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
      image: json['image'] as File,
      primaryCategory: json['primaryCategory'] as String,
      subCategory: json['subCategory'] as String,
      colors: json['colors'] as Set,
      detailTags: json['detailTags'] as Set
    );
  }
}