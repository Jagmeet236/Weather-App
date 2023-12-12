import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_weather_app/constants/style.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //initializing text theme
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(
          'Oops! Something went wrong.',
          style: textTheme.bodyLarge?.copyWith(
              fontFamily: GoogleFonts.roboto().fontFamily, color: blackColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
