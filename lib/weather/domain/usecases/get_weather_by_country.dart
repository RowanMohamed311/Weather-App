import 'package:weather/weather/domain/entities/weather.dart';
import 'package:weather/weather/domain/repository/base_weather_repository.dart';

class GetWeatherByCountry {
  // just reference from the abstract class not an object.
  final BaseWeatherRepository repository;
  GetWeatherByCountry(this.repository);

  Future<Weather> execute(String cityName) async {
    return await repository.getWeatherByCityName(cityName);
  }
}
