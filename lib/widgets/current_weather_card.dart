import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../models/weather_model.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({
    super.key,
    required Weather? weather,
    required this.currentDate,
    required this.weatherAnimation,
  }) : _weather = weather;

  final Weather? _weather;
  final String currentDate;
  final String weatherAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Text(
          _weather?.cityName ?? "loading city...",
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "$currentDate ",
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Lottie.asset(weatherAnimation),
        Text(
          "Temperature: ${_weather?.temperature.round() ?? 0}°C",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Feels like: ${_weather?.tempFeelsLike.round() ?? 0}°C",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Max Temperature: ${_weather?.maxTemp.round() ?? 0}°C",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Min Temperature: ${_weather?.minTemp.round() ?? 0}°C",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )
      ]),
    )));
  }
}
