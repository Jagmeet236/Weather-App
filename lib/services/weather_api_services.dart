import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_app/constants/constants.dart';
import 'package:open_weather_app/exception/weather_exception.dart';
import 'package:open_weather_app/models/models.dart';
import 'package:open_weather_app/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });
// This function takes a city name as input and returns the geocoding information for that city.
  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    // Construct the URI for the API request.
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      // Send a GET request to the API.
      final http.Response response = await httpClient.get(uri);

      // If the response status code is not 200, throw an error.
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      // Parse the response body.
      final responseBody = json.decode(response.body);

      // If the response body is empty, throw an error.
      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the location of $city');
      }

      // Convert the response body to a DirectGeocoding object.
      final directGeocoding = DirectGeocoding.fromJson(responseBody);

      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }

// This function takes a DirectGeocoding object as input and returns the weather information for that location.
  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    // Construct the URI for the API request.
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      // Send a GET request to the API.
      final http.Response response = await httpClient.get(uri);

      // If the response status code is not 200, throw an error.
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      // Parse the response body.
      final weatherJson = json.decode(response.body);

      // Convert the response body to a Weather object.
      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
