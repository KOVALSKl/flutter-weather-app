import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/utils/media_quaries.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ForecastWeatherCard extends StatelessWidget {
  const ForecastWeatherCard({
    super.key,
    required ForecastWeather forecast,
    required String animationName,
  })  : _forecast = forecast,
        _animationName = animationName;

  final ForecastWeather _forecast;
  final String _animationName;

  String getForecastDate(ForecastWeather forecastWeather) {
    DateFormat parseFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime parsedDate =
        parseFormatter.parse(forecastWeather.forecastDateString);

    DateFormat formatter = DateFormat("dd MMMM HH:mm");

    return formatter.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            getForecastDate(_forecast),
            style: GoogleFonts.montserrat(
              fontSize: (isDesktop(context)) ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Lottie.asset(_animationName, width: (isDesktop(context)) ? 170 : 120),
          Text(
            "Temperature: ${_forecast.temperature.round()}°C",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Max: ${_forecast.maxTemp.round()}°C",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Min: ${_forecast.minTemp.round()}°C",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Feels like: ${_forecast.tempFeelsLike.round()}°C",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
