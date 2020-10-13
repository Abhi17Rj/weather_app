import 'package:flutter/material.dart';
import 'location_page.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationPage(),
      theme: ThemeData.dark(),
    );
  }
}
