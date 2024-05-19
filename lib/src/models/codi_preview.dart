import 'dart:io';

import 'package:mococo_mobile/src/models/weather.dart';

class CodiPreview {
  final int id;
  // TODO: to image Type(File / XFile)
  final String image;
  final DateTime date;

  const CodiPreview({
    required this.id,
    required this.image,
    required this.date
  });

  factory CodiPreview.fromJson(Map<String, dynamic> json) {
    return CodiPreview(
        id: json['id'] as int,
        image: json['image'],
        date: DateTime.parse(json['date'])
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'image': image,
        'date': date.toIso8601String()
      };
}