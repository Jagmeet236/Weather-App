part of 'favorite_weather_cubit.dart';

enum FavoritesWeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class FavoritesWeatherState extends Equatable {
  final FavoritesWeatherStatus status;
  final List<FavoriteWeather> favorites;
  final CustomError error;

  FavoritesWeatherState({
    required this.status,
    required this.favorites,
    required this.error,
  });

  factory FavoritesWeatherState.initial() {
    return FavoritesWeatherState(
      status: FavoritesWeatherStatus.initial,
      favorites: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, favorites, error];

  @override
  String toString() =>
      'FavoritesState(status: $status, favorites: $favorites, error: $error)';

  FavoritesWeatherState copyWith({
    FavoritesWeatherStatus? status,
    List<FavoriteWeather>? favorites,
    CustomError? error,
  }) {
    return FavoritesWeatherState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      error: error ?? this.error,
    );
  }
}
