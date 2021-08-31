import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:weather/utilities/constants.dart';

import 'location_screen.dart';
import 'package:weather/services/weather.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'dart:core';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // double? latitude, longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // print(weatherData);
    // getData();

    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  // void getData() async {
  //   // int weatherCondition = decodeData['weather'][0]['id'];
  //   // print(weatherCondition);
  //   //
  //
  //   print('City : $cityName');
  //   print('Temperature is : $weatherTemperature');
  //   print('Weather Condition is : $weatherDescription');
  //
  //   // print(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      body: Center(
        child: Text(
          'Wait',
          style: kMessageTextStyle,
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: SpinKitSquareCircle(color: Colors.white, size: 50.0),
    //   ),
    // );
  }
}
/*
 Scaffold(
      body: Center(
        child: SpinKitSquareCircle(color: Colors.white, size: 50.0),
      ),
    );


* Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation();
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
* */
