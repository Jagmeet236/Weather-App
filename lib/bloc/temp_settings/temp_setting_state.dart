part of 'temp_setting_bloc.dart';

enum TempUnit {
  celsius,
  fahrenheit,
}

class TempSettingState extends Equatable {
  final TempUnit tempUnit;

  TempSettingState({this.tempUnit = TempUnit.celsius});

  factory TempSettingState.initial() {
    return TempSettingState();
  }

  @override
  List<Object> get props => [tempUnit];

  TempSettingState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

  @override
  String toString() => 'TempSettingsState(tempUnit: $tempUnit)';
}
