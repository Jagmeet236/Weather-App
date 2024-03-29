import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:open_weather_app/constants/weather_services.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ThemeChangedEvent>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }
  void setTheme(double currentTemp) {
    if (currentTemp > kWarmOrNot) {
      add(ThemeChangedEvent(appTheme: AppTheme.light));
    } else {
      add(ThemeChangedEvent(appTheme: AppTheme.dark));
    }
  }
}
