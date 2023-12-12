import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_app/bloc/bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title of the settings screen
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListTile(
          // List Tile for temperature unit setting
          title: Text('Temperature Unit'),
          subtitle: Text('Celsius/Fahrenheit (Default: Celsius)'),
          trailing: Switch(
            // Switch to toggle between Celsius and Fahrenheit
            value: context.watch<TempSettingBloc>().state.tempUnit ==
                TempUnit.celsius,
            onChanged: (_) {
              // Trigger an event to toggle the temperature unit
              context.read<TempSettingBloc>().add(ToggleTempUnitEvent());
            },
          ),
        ),
      ),
    );
  }
}
