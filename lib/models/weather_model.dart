class Weather {
  final String cityName;
  final double temperature;
  final double tempFeelsLike;
  final double maxTemp;
  final double minTemp;
  final String mainCondition;
  final String iconName;
  final double windSpeed;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.tempFeelsLike,
      required this.maxTemp,
      required this.minTemp,
      required this.mainCondition,
      required this.iconName,
      required this.windSpeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        tempFeelsLike: json['main']['feels_like'].toDouble(),
        maxTemp: json['main']['temp_max'].toDouble(),
        minTemp: json['main']['temp_min'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        iconName: json['weather'][0]['icon'],
        windSpeed: json['wind']['speed'].toDouble());
  }
}

class ForecastWeather {
  final double temperature;
  final double tempFeelsLike;
  final double maxTemp;
  final double minTemp;
  final String mainCondition;
  final String iconName;
  final double windSpeed;
  final DateTime forecastDay;
  final String forecastDateString;

  ForecastWeather({
    required this.temperature,
    required this.tempFeelsLike,
    required this.maxTemp,
    required this.minTemp,
    required this.mainCondition,
    required this.iconName,
    required this.windSpeed,
    required this.forecastDay,
    required this.forecastDateString,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
        temperature: json['main']['temp'].toDouble(),
        tempFeelsLike: json['main']['feels_like'].toDouble(),
        maxTemp: json['main']['temp_max'].toDouble(),
        minTemp: json['main']['temp_min'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        iconName: json['weather'][0]['icon'],
        windSpeed: json['wind']['speed'].toDouble(),
        forecastDateString: json['dt_txt'],
        forecastDay:
            DateTime.fromMicrosecondsSinceEpoch(json['dt'].toInt() * 1000));
  }
}
