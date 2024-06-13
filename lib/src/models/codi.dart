import 'package:mococo_mobile/src/models/clothes_list.dart';
import 'package:mococo_mobile/src/models/weather.dart';

class Codi {
  final int id;
  // TODO: to image Type(File / XFile)
  final String image;
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
        weather: (json['weather'].runtimeType is Weather)
          ? json['weather']
          : const Weather(location: "전주시", maxTemperature: 25, minTemperature: 19, precipitationType: "맑음", sky: "맑음"),
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