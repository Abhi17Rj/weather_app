import 'package:flutter/material.dart';
import 'package:weather_app/function/constants.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  ErrorPage({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
        ),
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Text(
            errorMessage,
            style: kTemperatureTextStyle,
          ),
        ),
      ),
    );
    ;
  }
}
