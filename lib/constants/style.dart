import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const appName = 'Weather App';

late Size size;

// Define your color constants
const Color redColor = Colors.red;
const Color blueColor = Colors.blue;
const Color greenColor = Colors.green;
const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;
const Color purpleColor = Colors.purple;
const Color deepPurpleColor = Colors.deepPurple;
const Color greyColor = Color.fromARGB(255, 98, 97, 97);

// Define custom text styles
TextStyle googleBoldTextStyle({double size = 14.0, Color color = blackColor}) {
  return GoogleFonts.robotoMono(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5);
}

TextStyle googleLightTextStyle({double size = 14.0, Color color = blackColor}) {
  return GoogleFonts.robotoMono(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5);
}

TextStyle customTextStyle = TextStyle(
  fontSize: 24,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.openSans().fontFamily,
);
