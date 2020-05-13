import 'dart:io';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String weatherMessage;
  int temp;
  int temperature;
  double tempe;
  String weatherIcon;
  String cityName;



  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }


  void updateUi(dynamic weatherData){
    setState(() {
      if (weatherData==null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
//      double temp = weatherData['main']['temp'];
//      temperature = temp.toInt();
//      var condition = weatherData['weather'][0]['id'];
//      weatherIcon = weather.getWeatherIcon(condition);
//      weatherMessage = weather.getMessage(temperature);
//      cityName = weatherData['name'];
      cityName = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon =weather.getWeatherIcon(condition);
//      if (Platform.isIOS) {
//        tempe = weatherData['main']['temp'];
//        temp = (tempe*1.0).toInt();
//        weatherMessage = weather.getMessage(temp);
//      } else {
//        temp = weatherData['main']['temp'];
////      temp = (tempe*1.0).toInt();
//        weatherMessage = weather.getMessage(temp);
//      }
      temp = weatherData['main']['temp'];
//      temp = (tempe*1.0).toInt();
      weatherMessage = weather.getMessage(temp);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData = await weather.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen(),),);
                      if (typedName!=null) {
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUi(weatherData);
                      }  
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                child: Center(
                  child: Text(
                    "$weatherMessage in $cityName!",
                    textAlign: TextAlign.right,
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


//String cityName = weatherData['name'];
//print(cityName);
//
//int condition = weatherData['weather'][0]['id'];
//print(condition);
//
//double temp = weatherData['main']['temp'];
//print(temp);
