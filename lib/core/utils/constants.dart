import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class AppContants {
  // make a static const bec, this is gonna be constant through the whole project
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String appKey = '420c315d900f03bb39f46bcf403631f5';

  static Map<String, IconData> weatherIcons = {
    'Clouds': WeatherIcons.cloudy,
    'Clear': WeatherIcons.sunset,
    'Rain': WeatherIcons.rain,
    'Snow': WeatherIcons.snowflake_cold,
    'Stormy': WeatherIcons.storm_showers,
    'Sunny': WeatherIcons.day_sunny,
    'Fog': WeatherIcons.day_fog,
    'Thunder': WeatherIcons.lightning
  };
}

class AppColorPalette {
  static const primarcolor = Color.fromARGB(255, 83, 53, 74);
  static const backgroundcolor = Color.fromARGB(255, 43, 46, 74);
  static const secondarycolor = Color.fromARGB(255, 144, 55, 73);
  static const preprimarycolor = Color.fromARGB(255, 232, 69, 69);
}

class AppColorPalette2 {
  static const primarcolor = Color.fromARGB(255, 78, 92, 239);

  static const backgroundcolor = Color.fromARGB(255, 37, 40, 54);
  static const secondarycolor = Color.fromARGB(255, 231, 72, 123);
  static const preprimarycolor = Color.fromARGB(255, 252, 255, 231);
  static const preprimarycolor2 = Color.fromARGB(255, 143, 83, 189);
  static var textstyle = const TextStyle(
    color: AppColorPalette2.preprimarycolor,
  );
  static var textstyleTiltle = const TextStyle(
      color: AppColorPalette2.preprimarycolor,
      fontWeight: FontWeight.w400,
      fontSize: 18);

  static var textstyleInfo = const TextStyle(
      color: AppColorPalette2.preprimarycolor,
      fontWeight: FontWeight.w900,
      fontSize: 22);
}
