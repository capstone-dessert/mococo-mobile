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
      location: json['addressName'],
      maxTemperature: json['maxTemperature'].toInt(),
      minTemperature: json['minTemperature'].toInt(),
      precipitationType: json['precipitationType'],
      sky: json['sky']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'addressName': location,
        'maxTemperature': maxTemperature.toDouble(),
        'minTemperature': minTemperature.toDouble(),
        'precipitationType': precipitationType,
        'sky': sky
      };
}