class Weather {
  final String location;
  final int maxTemperature;
  final int minTemperature;
  final String precipitationType;
  final String sky;

  const Weather({
    required this.location,
    required this.maxTemperature,
    required this.minTemperature,
    required this.precipitationType,
    required this.sky
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: json['addressName'] as String,
      maxTemperature: json['maxTemperature'] as int,
      minTemperature: json['minTemperature'] as int,
      precipitationType: json['precipitationType'] as String,
      sky: json['sky'] as String
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'addressName': location,
        'maxTemperature': maxTemperature,
        'minTemperature': minTemperature,
        'precipitationType': precipitationType,
        'sky': sky
      };
}