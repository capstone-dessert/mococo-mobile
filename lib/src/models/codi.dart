import 'dart:typed_data';

import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/weather.dart';

class Codi {
  final int id;
  final Uint8List image;
  final DateTime date;
  final Weather weather;
  final String schedule;
  final ClothesList clothes;

  const Codi({
    required this.id,
    required this.image,
    required this.date,
    required this.weather,
    required this.schedule,
    required this.clothes
  });

  factory Codi.fromJson(Map<String, dynamic> json) {
    return Codi(
        id: json['id'] as int,
        image: json['image'],
        date: DateTime.parse(json['date']),
        weather: (json['weather'].runtimeType == Weather)
          ? json['weather']
          : Weather.fromJson(json['weather']),
        schedule: json['schedule'],
        clothes: ClothesList.fromJson({'list': json['clothingItems']})
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'image': image,
        'date': date.toIso8601String(),
        'location': weather.location,
        'schedules': schedule,
        'clothes': clothes,
      };
}