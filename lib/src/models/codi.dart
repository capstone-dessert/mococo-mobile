import 'dart:io';

import 'package:mococo_mobile/src/models/weather.dart';

class Codi {
  final int id;
  // TODO: image Type - File / XFile
  final File image;
  final DateTime date;
  final Weather weather;
  final Set schedules;
  final Set clothes;

  const Codi({
    required this.id,
    required this.image,
    required this.date,
    required this.weather,
    required this.schedules,
    required this.clothes
  });

  factory Codi.fromJson(Map<String, dynamic> json) {
    return Codi(
        id: json['id'] as int,
        image: json['image'] as File,
        date: json['date'] as DateTime,
        weather: json['weather'] as Weather,
        schedules: json['schedules'] as Set,
        clothes: json['clothes'] as Set
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'image': image,
        'date': date,
        'weather': weather,
        'schedules': schedules,
        'clothes': clothes,
      };
}