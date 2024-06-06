import 'dart:typed_data';

class ClothesPreview {
  final int id;
  final Uint8List image;

  const ClothesPreview({
    required this.id,
    required this.image
  });

  factory ClothesPreview.fromJson(Map<String, dynamic> json) {
    return ClothesPreview(
      id: json['id'] as int,
      image: json['image']
    );
  }


  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'image': image
    };
}