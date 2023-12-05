import 'dart:async';

import 'package:open_weather_app/exception/weather_exception.dart';
import 'package:open_weather_app/models/models.dart';
import 'package:open_weather_app/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });
  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding = await weatherApiServices
          .getDirectGeocoding(city)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('The connection has timed out!');
      });
      print('directGeocoding: $directGeocoding');

      final Weather tempWeather = await weatherApiServices
          .getWeather(directGeocoding)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('The connection has timed out!');
      });

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } on TimeoutException catch (e) {
      throw CustomError(errMsg: e.message!);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
