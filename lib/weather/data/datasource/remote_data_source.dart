import 'dart:convert';

import 'package:weather/weather/data/models/weather_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/constants.dart';

abstract class BaseRemoteDataSource {
  Future<WeatherModel> getWeatherByCountryName(String countryName);
}

// concrete implementation
class RemoteDataSource implements BaseRemoteDataSource {
  @override
  Future<WeatherModel> getWeatherByCountryName(String countryName) async {
    // TODO: implement getWeatherByCountryName
    final dio = Dio();
    final response = await dio.get(
      '${AppContants.baseUrl}/weather?q=$countryName&appid=${AppContants.appKey}',
    );
    print(response.data);
    print(response.data['weather'][0]['main']);
    print(WeatherModel.fromJson(response.data));
    return WeatherModel.fromJson(response.data);
  }
}
