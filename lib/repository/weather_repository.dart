import 'dart:async';

import 'package:open_weather_app/exception/weather_exception.dart';
import 'package:open_weather_app/models/models.dart';
import 'package:open_weather_app/services/weather_api_services.dart';

class WeatherRepository {
  // Inject the weather API services dependency
  final WeatherApiServices weatherApiServices;

  // Initialize the repository
  WeatherRepository({
    required this.weatherApiServices,
  });

  // Fetches weather data for a given city
  Future<Weather> fetchWeather(String city) async {
    try {
      // Get the city's geographical coordinates
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);
      print('directGeocoding: $directGeocoding'); // Print debug information

      // Get weather data for the location
      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);

      // Combine weather data with location details
      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      // Return the complete weather information
      return weather;
    } on WeatherException catch (e) {
      // Wrap specific weather API exceptions
      throw CustomError(errMsg: e.message);
    } on TimeoutException catch (e) {
      // Handle connection timeout exceptions
      throw CustomError(errMsg: e.message!);
    } catch (e) {
      // Handle any other unexpected exceptions
      throw CustomError(errMsg: e.toString());
    }
  }
}
