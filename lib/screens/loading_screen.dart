import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';
import './location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
//    var temp = jsonDecode(data)['main']['temp'];
//    var weather = jsonDecode(data)['weather'][0]['id'];
//    var city = jsonDecode(data)['name'];
//    print(temp);
//    print(weather);
//    print(city);
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
