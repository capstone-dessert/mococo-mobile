import 'dart:io';

import 'package:mococo_mobile/src/models/weather.dart';

class ItemPreview {
  final int id;
  // TODO: to image Type(File / XFile)
  final String image;

  const ItemPreview({
    required this.id,
    required this.image
  });

  factory ItemPreview.fromJson(Map<String, dynamic> json) {
    return ItemPreview(
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