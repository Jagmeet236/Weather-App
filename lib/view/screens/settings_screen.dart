import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_app/cubits/temperature/temp_settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListTile(
            title: Text('Temperature Unit'),
            subtitle: Text('Celsius/Fahrenheit (Default: Celsius)'),
            trailing: Switch(
              value: context.watch<TempSettingsCubit>().state.tempUnit ==
                  TempUnit.celsius,
              onChanged: (_) {
                context.read<TempSettingsCubit>().toggleTempUnit();
              },
            ),
          ),
        ));
  }
}
