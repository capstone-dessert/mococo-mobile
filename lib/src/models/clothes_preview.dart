import 'dart:typed_data';

class ClothesPreview {
  final int id;
  final Uint8List image;
  final String category;

  const ClothesPreview({
    required this.id,
    required this.image,
    required this.category
  });

  factory ClothesPreview.fromJson(Map<String, dynamic> json) {
    return ClothesPreview(
      id: json['id'] as int,
      image: json['image'],
      category: json['category']
    );
  }


  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'image': image,
      'category': category
    };
}