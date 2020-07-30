import 'package:clima/screens/city_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  double temp;
  int condition;
  String city, weather;
  String img = "location_background";
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        condition = -1;
        city = "";
        img = "location_background";
        weather = "Error in finding Location";
        return;
      }
      temp = weatherData['main']['temp'];
      temp = ((temp * 10).floor()) / 10;
      condition = weatherData['weather'][0]['id'];
      city = weatherData['name'];
      if (condition < 300) {
        img = "thunderstorm";
      } else if (condition < 400) {
        img = "drizzle";
      } else if (condition < 600) {
        img = "rain";
      } else if (condition < 700) {
        img = "snow";
      } else if (condition < 800) {
        img = "clouds";
      } else if (condition == 800) {
        img = "clear";
      } else if (condition <= 804) {
        img = "clouds";
      } else {
        img = "location_background";
      }

      weather = weatherModel.getMessage(temp.toInt()) + " in " + city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$img.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      print("reloadin weather");
                      var weatherData = await weatherModel.getWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (cityName != "" && cityName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(cityName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherModel.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    weather,
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
