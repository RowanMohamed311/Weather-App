import 'package:weather/weather/domain/entities/weather.dart';

abstract class BaseWeatherRepository {
  // as a contract to connect with anny other layer, so the class will be abstract class.
  // apply DIP of the solid pricipals.
  Future<Weather> getWeatherByCityName(String cityName);
}
