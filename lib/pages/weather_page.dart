import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:flutter_weather_app/utils/media_quaries.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../widgets/current_weather_card.dart';
import '../widgets/forecast_weather_card.dart';

const API_KEY = "7a1947745118a5fca6d8e156f4724528";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(API_KEY);
  Weather? _weather;
  List<ForecastWeather> _forecast = [];
  String? _cityName;
  late String currentDate;

  _fetchCityName() async {
    String cityName = await _weatherService.getCurrentCityName();

    setState(() {
      _cityName = cityName;
    });
  }

  _updateCityName(String value) {
    setState(() {
      _cityName = value;
    });
  }

  _fetchCurrentWeather() async {
    String cityName = _cityName ?? await _weatherService.getCurrentCityName();

    try {
      final weather = await _weatherService.getCurrentDayWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  _fetchWeekForecast() async {
    String cityName = _cityName ?? await _weatherService.getCurrentCityName();

    try {
      final forecastList = await _weatherService.getWeekForecast(cityName);
      setState(() {
        _forecast = forecastList;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? iconName) {
    late String assetName;

    switch (iconName) {
      case "03d":
      case "04d":
        assetName = "02d";
      case "03n":
      case "04n":
        assetName = "02n";
      case "10d":
        assetName = "11d";
      case "10n":
        assetName = "11n";
      case "50d":
      case "50n":
        assetName = "50nd";
      default:
        assetName = iconName ?? "01d";
    }

    return "images/$assetName.json";
  }

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("dd MMMM yyyy");
    currentDate = formatter.format(now);

    _fetchCityName();
    _fetchCurrentWeather();
    _fetchWeekForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Weather App",
          style: GoogleFonts.montserratAlternates(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 93, 183, 231),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 300,
          child: SearchBar(
            leading: const Icon(Icons.search),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            elevation: const MaterialStatePropertyAll<double>(1.0),
            hintText: "Enter city name...",
            onSubmitted: (value) {
              _updateCityName(value);
              _fetchCurrentWeather();
              _fetchWeekForecast();
            },
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
            width: 350,
            child: CurrentWeatherCard(
              weather: _weather,
              currentDate: currentDate,
              weatherAnimation: getWeatherAnimation(_weather?.iconName),
            )),
        const SizedBox(height: 30),
        SizedBox(
            height: 250,
            width: (isDesktop(context)) ? 800 : 340,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.stylus
                }),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _forecast.length,
                  itemBuilder: (context, index) {
                    return ForecastWeatherCard(
                      forecast: _forecast[index],
                      animationName:
                          getWeatherAnimation(_forecast[index].iconName),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                ),
              ),
            )),
      ],
    ))));
  }
}
