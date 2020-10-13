import 'package:flutter/material.dart';
import 'package:weather_app/error_page.dart';
import 'package:weather_app/function/weather_data.dart';
import 'package:weather_app/weather_display_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String errorMessage;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherOutput().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DisplayWeatherPage(weatherData: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        constraints: BoxConstraints.expand(),
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
