import 'package:equatable/equatable.dart';
import 'package:open_weather_app/models/weather.dart';

class FavoriteWeather extends Equatable {
  final String name;
  final double temperature;
  final DateTime lastUpdated;

  FavoriteWeather(
      {required this.name,
      required this.temperature,
      required this.lastUpdated});

// Factory constructor to convert from Weather
  factory FavoriteWeather.fromWeather(Weather weather) {
    return FavoriteWeather(
      name: weather.name,
      temperature: weather.temp,
      lastUpdated: weather.lastUpdated,
    );
  }
  // Optional constructor to allow manual creation
  // (e.g., for restoring from persistent storage)
  factory FavoriteWeather.fromJson(Map<String, dynamic> json) {
    return FavoriteWeather(
      name: json['name'] as String,
      temperature: json['temperature'] as double,
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  // Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'temperature': temperature,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  @override
  String toString() =>
      'FavoriteWeather(name: $name, temperature: $temperature, lastUpdated: $lastUpdated,)';

  @override
  List<Object> get props => [name, temperature, lastUpdated];
}
