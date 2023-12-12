import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_app/bloc/favorite_weather/favorite_weather_cubit.dart';
import 'package:open_weather_app/bloc/temp_settings/temp_setting_bloc.dart';

class FavoriteWeatherScreen extends StatefulWidget {
  const FavoriteWeatherScreen({super.key});

  @override
  State<FavoriteWeatherScreen> createState() => _FavoriteWeatherScreenState();
}

class _FavoriteWeatherScreenState extends State<FavoriteWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocBuilder<FavoriteWeatherCubit, FavoritesWeatherState>(
        builder: (context, state) {
          if (state.status == FavoritesWeatherStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == FavoritesWeatherStatus.error) {
            return Center(child: Text('Error: ${state.error.errMsg}'));
          } else {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                return ListTile(
                  title: Text(
                    favorite.name,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  subtitle: Text(
                    TimeOfDay.fromDateTime(favorite.lastUpdated)
                        .format(context),
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  trailing: Text(
                    showTemperature(favorite.temperature),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Formats the temperature based on the user's temperature unit preference.
  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingBloc>().state.tempUnit;

    if (tempUnit == TempUnit.fahrenheit) {
      return ((temperature * 9 / 5) + 32).toStringAsFixed(2) + '℉';
    }

    return temperature.toStringAsFixed(2) + '℃';
  }

  // Formats the weather description for better readability.
  Widget formatText(String description) {
    final formattedString = description;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
    );
  }
}
