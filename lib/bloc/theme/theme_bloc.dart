import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_app/bloc/bloc.dart';
import 'package:open_weather_app/constants/weather_services.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final WeatherBloc weatherBloc;
  late StreamSubscription weatherSubscription;
  ThemeBloc({required this.weatherBloc}) : super(ThemeState.initial()) {
    weatherSubscription =
        weatherBloc.stream.listen((WeatherState weatherState) {
      if (weatherState.weather.temp > kWarmOrNot) {
        add(ThemeChangedEvent(appTheme: AppTheme.light));
      } else {
        add(ThemeChangedEvent(appTheme: AppTheme.dark));
      }
    });
    on<ThemeChangedEvent>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }
  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
