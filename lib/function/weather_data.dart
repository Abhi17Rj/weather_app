import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'location.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherOutput {
  Future<dynamic> getCityWeather(var cityName) async {
    var weatherData;
    http.Response response =
        await http.get('$cityUrl?q=$cityName&units=metric&appid=$apiKey');

    if (response.statusCode == 200) {
      weatherData = response.body;
      return jsonDecode(weatherData);
    } else {
      weatherData = response.statusCode;
      print('City not Found');
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();
    double long = location.longitude;
    double lat = location.latitude;
    print(long);
    print(lat);

    var weatherData;
    http.Response response =
        await http.get('$locUrl?lat=$lat&lon=$long&units=metric&appid=$apiKey');

    if (response.statusCode == 200) {
      weatherData = response.body;
    } else {
      weatherData = response.statusCode;
    }
    print('Error : ');
    print(response);
    print(weatherData);

    return jsonDecode(weatherData);
  }

  IconData getWeatherIcon(int weatherID) {
    if (weatherID < 250) {
      return WeatherIcons.thunderstorm;
    } else if (weatherID < 350) {
      return WeatherIcons.raindrops;
    } else if (weatherID < 550) {
      return WeatherIcons.rain;
    } else if (weatherID < 650) {
      return WeatherIcons.snow;
    } else if (weatherID < 750) {
      return WeatherIcons.smog;
    } else if (weatherID < 801) {
      return WeatherIcons.day_sunny;
    } else {
      return WeatherIcons.cloudy;
    }
  }

  String getBgImage(String code) {
    if (code == '01d') {
      return 'images/sunny.jpg';
    } else if (code == '10d' || code == '10n') {
      return 'images/rainy.png';
    } else if (code == '01n') {
      return 'images/night.jpg';
    } else if (code == '13d') {
      return 'images/snow.jpg';
    } else {
      return 'images/cloudy.jpg';
    }
  }

  String getUVlevel(double value) {
    if (value < 2.0) {
      return 'Low';
    } else if (value < 5.0) {
      return 'Moderate';
    } else if (value < 7.0) {
      return 'High';
    } else if (value < 10.0) {
      return 'Very High';
    } else {
      return 'Extreme';
    }
  }

  String getWindDirection(int angle) {
    if (angle < 10) {
      return 'North';
    } else if (angle < 80) {
      return 'North-East';
    } else if (angle < 100) {
      return 'East';
    } else if (angle < 170) {
      return 'South-East';
    } else if (angle < 190) {
      return 'South';
    } else if (angle < 260) {
      return 'South-West';
    } else if (angle < 280) {
      return 'West';
    } else if (angle < 320) {
      return 'North-West';
    } else {
      return 'North';
    }
  }

  String getTime(int epochTime) {
    var convertedDateTime =
        DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);
    print(convertedDateTime);
    String formattedTime = DateFormat.jm().format(convertedDateTime);
    print(formattedTime);
    return formattedTime;
  }
}
