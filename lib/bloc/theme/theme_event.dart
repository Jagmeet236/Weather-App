part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChangedEvent extends ThemeEvent {
  final AppTheme appTheme;

  const ThemeChangedEvent({required this.appTheme});

  @override
  List<Object> get props => [appTheme];
}
