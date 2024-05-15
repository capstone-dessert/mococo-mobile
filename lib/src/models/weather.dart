class Weather {
  final String location;
  final int highTemperature;
  final int lowTemperature;
  final String weatherCondition;

  const Weather({
    required this.location,
    required this.highTemperature,
    required this.lowTemperature,
    required this.weatherCondition
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        location: json['location'] as String,
        highTemperature: json['highTemperature'] as int,
        lowTemperature: json['lowTemperature'] as int,
        weatherCondition: json['weatherCondition'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'location': location,
        'highTemperature': highTemperature,
        'lowTemperature': lowTemperature,
        'weatherCondition': weatherCondition,
      };
}