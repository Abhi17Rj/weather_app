import 'package:flutter/material.dart';
import 'package:weather_app/function/constants.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  var cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/sunrise.png'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.dstATop),
        ),
      ),
      constraints: BoxConstraints.expand(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 50.0),
                width: double.infinity,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 45.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                  },
                  style: kInputStyle,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.grey.shade200,
                      size: 30.0,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    hintText: 'Enter a City',
                    hintStyle: TextStyle(color: Colors.grey.shade900),
                  ),
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context, cityName.toString());
                  },
                  child: Text(
                    'Get Weather',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                    ),
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
