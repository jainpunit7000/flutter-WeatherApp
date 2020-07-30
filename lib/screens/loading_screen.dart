import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';
import './location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude, longitude;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeather();
//    print(weatherData) ;
    var value = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
//    print("here it is $value");
    if (value == null) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
