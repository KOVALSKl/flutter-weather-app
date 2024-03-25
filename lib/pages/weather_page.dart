import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("7a1947745118a5fca6d8e156f4724528");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCityName();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
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

    return "$assetName.json";
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_weather?.cityName ?? "loading city..."),
        Lottie.asset(getWeatherAnimation(_weather?.iconName)),
        Text("${_weather?.temperature.round()}°C")
      ],
    )));
  }
}
