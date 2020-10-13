import 'package:flutter/material.dart';
import 'package:weather_app/function/constants.dart';
import 'package:weather_app/function/weather_data.dart';
import 'package:weather_icons/weather_icons.dart';
import 'enter_city_page.dart';

class DisplayWeatherPage extends StatefulWidget {
  final weatherData;

  DisplayWeatherPage({this.weatherData});

  @override
  _DisplayWeatherPageState createState() => _DisplayWeatherPageState();
}

class _DisplayWeatherPageState extends State<DisplayWeatherPage> {
  int temperature;
  String cityName;
  String weatherDetails;
  int feelsLike;
  IconData icon;
  String bgImage;
  double windSpeed;
  int pressure;
  int humidity;
  String windDirection;
  String sunrise;
  String sunset;
  String currentTime;
  String country;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        print('cannot fetch data');
      } else {
        temperature = weatherData['main']['temp'].round();
        cityName = weatherData['name'];
        weatherDetails = weatherData['weather'][0]['description'];
        feelsLike = weatherData['main']['temp'].round();
        dynamic weatherOutput = WeatherOutput();
        icon = weatherOutput.getWeatherIcon(weatherData['weather'][0]['id']);
        bgImage = weatherOutput.getBgImage(weatherData['weather'][0]['icon']);
        windDirection =
            weatherOutput.getWindDirection(weatherData['wind']['deg']);
        pressure = weatherData['main']['pressure'];
        windSpeed = weatherData['wind']['speed'];
        humidity = weatherData['main']['humidity'];
        sunrise = weatherOutput.getTime(weatherData['sys']['sunrise']);
        sunset = weatherOutput.getTime(weatherData['sys']['sunset']);
        currentTime = weatherOutput.getTime(weatherData['dt']);
        country = weatherData['sys']['country'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          var weathData =
                              await WeatherOutput().getLocationWeather();
                          updateUI(weathData);
                        },
                        child: Icon(
                          Icons.my_location,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        '$cityName, $country',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w200),
                      ),
                      FlatButton(
                        onPressed: () async {
                          var cityName = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityPage();
                          }));

                          if (cityName != null) {
                            var weathData =
                                await WeatherOutput().getCityWeather(cityName);
                            updateUI(weathData);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 70.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 32.0),
                    Text(
                        '${weatherDetails[0].toUpperCase()}${weatherDetails.substring(1)}',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                    SizedBox(height: 6.0),
                    Text(
                      '$temperature°',
                      style: kTemperatureTextStyle,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(65.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: 230.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Feels like $feelsLike°',
                              style: kDetailsTextStyle,
                            ),
                            Text(
                              'Last updated on $currentTime',
                              style: kWeatherDetailsTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.white12,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new WeatherIconData(
                                      weatherIcon: WeatherIcons.barometer,
                                      weatherData:
                                          '${pressure.toString()} mbar',
                                    ),
                                    new WeatherIconData(
                                      weatherIcon: WeatherIcons.wind_beaufort_0,
                                      weatherData:
                                          '${windSpeed.toString()} km/h',
                                    ),
                                    new WeatherIconData(
                                      weatherIcon: WeatherIcons.sunrise,
                                      weatherData: sunrise,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new WeatherIconData(
                                      weatherIcon: WeatherIcons.humidity,
                                      weatherData: '${humidity.toString()} %',
                                    ),
                                    new WeatherIconData(
                                      weatherIcon: WeatherIcons.wind_direction,
                                      weatherData: windDirection,
                                    ),
                                    new WeatherIconData(
                                      weatherIcon: WeatherIcons.sunset,
                                      weatherData: sunset,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherIconData extends StatelessWidget {
  final IconData weatherIcon;
  final String weatherData;

  WeatherIconData({this.weatherIcon, this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: Icon(
                weatherIcon,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                weatherData,
                style: kWeatherDetailsTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
