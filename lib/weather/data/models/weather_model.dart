import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel(
      super.id,
      super.cityName,
      super.main,
      super.description,
      super.pressure,
      super.lat,
      super.lon,
      super.wind_speed,
      super.temp,
      super.humitity);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        json['id'],
        json['name'],
        json['weather'][0]['main'],
        json['weather'][0]['description'],
        json['main']['pressure'],
        json['coord']['lat'],
        json['coord']['lon'],
        json['wind']['speed'],
        json['main']['temp'],
        json['main']['humidity']);
  }
}
