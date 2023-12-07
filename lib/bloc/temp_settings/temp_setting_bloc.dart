import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_setting_event.dart';
part 'temp_setting_state.dart';

class TempSettingBloc extends Bloc<TempSettingEvent, TempSettingState> {
  TempSettingBloc() : super(TempSettingState.initial()) {
    on<ToggleTempUnitEvent>(_toggleTempUnit);
  }

  void _toggleTempUnit(
      ToggleTempUnitEvent event, Emitter<TempSettingState> emit) {
    emit(state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celsius
            ? TempUnit.fahrenheit
            : TempUnit.celsius));
  }
}
