// import 'dart:html';

import 'dart:ui';
import 'package:weather_icons/weather_icons.dart';

import 'package:flutter/material.dart';
import 'package:weather/core/utils/constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;
import '../../data/datasource/remote_data_source.dart';
import '../../data/repository/weather_repository.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repository/base_weather_repository.dart';
import '../../domain/usecases/get_weather_by_country.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
  // String? isoCountryCode = systemLocales.first.countryCode;
// var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
// String yourCityName = address.first.locality
  loc.Location location = loc.Location();
  String search_country = 'egypt';
  String cityName = '';
  double lon = 0;
  double lat = 0;
  String main = '';
  var cur_lat;
  var cur_lon;
  double speed = 0;
  double temp = 0;
  double temp_c = 0;
  double feel = 0;
  int humidity = 0;
  String currentCountry = '';
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationCoordinates();
    Future.delayed(const Duration(milliseconds: 1000));

    // getWeather();
  }

  Future getLocationCoordinates() async {
    loc.Location location = loc.Location();
    try {
      await location.serviceEnabled().then((value) async {
        if (!value) {
          await location.requestService();
        }
      });
      final coordinates = await location.getLocation();
      cur_lat = coordinates.latitude;
      cur_lon = coordinates.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
          coordinates.latitude!, coordinates.longitude!);
      Placemark place = placemarks[0];
      setState(() {
        currentCountry = place.country!;
      });
      print('testplace : ' + place.country.toString());
      setState(() {
        search_country = place.country.toString();
      });
      getWeather();
    } catch (e) {
      print(e);
      return null;
    }
  }

  getWeather() async {
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseWeatherRepository baseWeatherRepository =
        WeatherRepository(baseRemoteDataSource);
    Weather weather = await GetWeatherByCountry(baseWeatherRepository)
        .execute(search_country);
    setState(() {
      cityName = weather.cityName;
      lon = weather.lon;
      lat = weather.lat;
      main = weather.main;
      temp = weather.temp;
      temp_c = temp - 273.15;
      speed = weather.wind_speed;
      humidity = weather.humitity;
      feel = weather.feel - 273.15;
    });
    print(weather.cityName);
    print(weather.lon);
    print(weather.lat);
    print(weather.wind_speed);
    print(weather.humitity);
    print(weather.temp);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColorPalette2.backgroundcolor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColorPalette2.preprimarycolor2.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search City....',
                            hintStyle: TextStyle(
                                color: AppColorPalette2.preprimarycolor,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            search_country = searchController.text;
                          });
                          getWeather();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  // decoration: BoxDecoration(
                  //   color: AppColorPalette2.preprimarycolor2.withOpacity(0.1),
                  //   borderRadius: const BorderRadius.all(
                  //     Radius.circular(20),
                  //   ),
                  // ),
                  // ignore: sort_child_properties_last
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cityName,
                        style: AppColorPalette2.textstyle.copyWith(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 15,
                            color: AppColorPalette2.preprimarycolor
                                .withOpacity(0.5),
                          ),
                          Text(
                            ' $lon, $lat',
                            style: TextStyle(
                              color: AppColorPalette2.preprimarycolor
                                  .withOpacity(0.5),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColorPalette2.preprimarycolor2.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                temp_c.toStringAsFixed(2),
                                style: AppColorPalette2.textstyleInfo,
                              ),
                              const BoxedIcon(WeatherIcons.celsius,
                                  color: Colors.white, size: 25),
                            ],
                          ),
                          Text(
                            'Feels Like ' + feel.toStringAsFixed(2),
                            style: AppColorPalette2.textstyleTiltle.copyWith(
                                fontWeight: FontWeight.w100, fontSize: 15),
                          ),
                        ],
                      ),
                      // const Icon(
                      //   Icons.sunny,
                      //   color: Colors.white,
                      //   size: 70,
                      // ),
                      const BoxedIcon(WeatherIcons.sunrise,
                          color: Colors.white, size: 70),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  // decoration: BoxDecoration(
                  //   color: AppColorPalette2.primarcolor.withOpacity(0.2),
                  //   borderRadius: const BorderRadius.all(
                  //     Radius.circular(20),
                  //   ),
                  // ),
                  // ignore: sort_child_properties_last
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        main,
                        style: AppColorPalette2.textstyleTiltle
                            .copyWith(fontSize: 40),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 370,
                  height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColorPalette2.preprimarycolor2,
                        offset: Offset(0, 1),
                        blurRadius: 30,
                        spreadRadius: -20,
                      ),
                    ],
                    gradient: LinearGradient(
                        colors: [
                          AppColorPalette2.secondarycolor,
                          AppColorPalette2.preprimarycolor2,
                          AppColorPalette2.preprimarycolor2,
                          AppColorPalette2.primarcolor
                          //add more colors for gradient
                        ],
                        begin: Alignment.topLeft, //begin of the gradient color
                        end: Alignment.bottomRight, //end of the gradient color
                        stops: [0, 0.4, 0.6, 0.8] //stops for individual color
                        //set the stops number equal to numbers of color
                        ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Wind', style: AppColorPalette2.textstyleTiltle),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                '$speed ',
                                style: AppColorPalette2.textstyleInfo,
                              ),
                              Text(
                                'Km/h',
                                style: AppColorPalette2.textstyleTiltle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Temp', style: AppColorPalette2.textstyleTiltle),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                temp_c.toStringAsFixed(2),
                                style: AppColorPalette2.textstyleInfo,
                              ),
                              const BoxedIcon(WeatherIcons.celsius,
                                  color: Colors.white, size: 25),
                            ],
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Humidity',
                              style: AppColorPalette2.textstyleTiltle),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                '$humidity ',
                                style: AppColorPalette2.textstyleInfo,
                              ),
                              Text(
                                '%',
                                style: AppColorPalette2.textstyleTiltle,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
