import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_app/models/custom_error.dart';
import 'package:open_weather_app/models/favorite_weather.dart';
import 'package:open_weather_app/models/weather.dart';
import 'package:open_weather_app/repository/weather_repository.dart';
part 'favorite_weather_state.dart';

class FavoriteWeatherCubit extends Cubit<FavoritesWeatherState> {
  final WeatherRepository weatherRepository;

  FavoriteWeatherCubit({required this.weatherRepository})
      : super(FavoritesWeatherState.initial());
  void addFavorite(String city) async {
    emit(state.copyWith(status: FavoritesWeatherStatus.loading));
    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      final FavoriteWeather favorite = FavoriteWeather.fromWeather(weather);

      // Check if the city is already in the favorites
      if (state.favorites.any((fav) => fav.name == favorite.name)) {
        // If it is, don't add it again
        emit(state.copyWith(status: FavoritesWeatherStatus.loaded));
      } else {
        // If it's not, add it to the favorites
        List<FavoriteWeather> updatedFavorites = List.from(state.favorites)
          ..add(favorite);

        emit(state.copyWith(
          status: FavoritesWeatherStatus.loaded,
          favorites: updatedFavorites,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesWeatherStatus.error,
        error: CustomError(errMsg: e.toString()),
      ));
    }
  }

  void removeFavorite(FavoriteWeather favorite) {
    try {
      emit(state.copyWith(
        status: FavoritesWeatherStatus.loading,
      ));

      List<FavoriteWeather> updatedFavorites = List.from(state.favorites)
        ..remove(favorite);

      emit(state.copyWith(
        status: FavoritesWeatherStatus.loaded,
        favorites: updatedFavorites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesWeatherStatus.error,
        error: CustomError(errMsg: e.toString()),
      ));
    }
  }
}
