import 'package:flutter/material.dart';
import 'package:weather/weather/data/datasource/remote_data_source.dart';
import 'package:weather/weather/data/repository/weather_repository.dart';
import 'package:weather/weather/domain/entities/weather.dart';
import 'package:weather/weather/domain/repository/base_weather_repository.dart';
import 'package:weather/weather/domain/usecases/get_weather_by_country.dart';
import 'package:weather/weather/presentation/screens/weather_screen.dart';

void main() {
  // BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
  // BaseWeatherRepository baseWeatherRepository =
  //     WeatherRepository(baseRemoteDataSource);
  // Weather weather =
  //     await GetWeatherByCountry(baseWeatherRepository).execute('Egypt');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}
