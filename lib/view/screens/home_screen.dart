import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:open_weather_app/bloc/bloc.dart';
import 'package:open_weather_app/constants/style.dart';
import 'package:open_weather_app/constants/weather_services.dart';

import 'package:open_weather_app/view/view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/home/favorite');
            },
            icon: Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
            onPressed: () async {
              _city = await context.push('/home/search');
              print('$_city');
              if (_city != null) {
                context.read<WeatherBloc>().add(FetchWeatherEvent(
                    city:
                        _city!)); // Adds a FetchWeatherEvent to the WeatherBloc
                print('$_city');
              }
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              context.goNamed('settings');
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: _showWeather(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_city != null) {
            context.read<FavoriteWeatherCubit>().addFavorite(_city!);
          }
        },
        child: const Icon(Icons.favorite),
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

  // Fetches the weather icon image from the internet.
  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: 'http://$kIconHost/img/wn/$icon@4x.png',
        width: 96,
        height: 96,
        imageErrorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return Lottie.asset('assets/lottie/loadingAnimation.json',
              width: 96, height: 96);
        });
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

  Widget _showWeather() {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<WeatherBloc>()
                .add(FetchWeatherEvent(city: state.weather.name)); //refresh
          },
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                state.weather.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    TimeOfDay.fromDateTime(state.weather.lastUpdated)
                        .format(context),
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    '(${state.weather.country})',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              const SizedBox(height: 60.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    showTemperature(state.weather.temp),
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    children: [
                      Text(
                        showTemperature(state.weather.tempMax),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        showTemperature(state.weather.tempMin),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  showIcon(state.weather.icon),
                  Expanded(
                    flex: 3,
                    child: formatText(state.weather.description),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
