import 'dart:io';

import 'package:mococo_mobile/src/models/weather.dart';

class Codi {
  final int id;
  // TODO: to image Type(File / XFile)
  final String image;
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
        image: json['image'],
        date: DateTime.parse(json['date']),
        weather: Weather(location: json["location"], highTemperature: 25, lowTemperature: 19, weatherCondition: "맑음"),
        schedules: json['schedules'] as Set,
        clothes: json['clothes'] as Set
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'image': image,
      'date': date.toIso8601String(),
      'location': weather.location,
      'schedules': schedules,
      'clothes': clothes,
    };
}