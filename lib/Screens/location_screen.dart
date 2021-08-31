import 'package:flutter/material.dart';
import 'package:weather/Screens/city_screen.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

// void convertionKtoC(double weatherTemperature) {
//   {
//     double Temperature = weatherTemperature - 273.15;
//
//     print('new temp is : $Temperature');
//   }
// }

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  String? weatherDescription, cityName;
  double? weatherTemperature;
  int? temperature;
  String? weatherIcon, weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      weatherTemperature = weatherData['main']['temp'];
      temperature = weatherTemperature!.toInt();
      // print(temperature);

      cityName = weatherData['name'];

      var weatherCondition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(weatherCondition);

      weatherMessage = weather.getMessage(temperature!);

      weatherDescription = weatherData['weather'][0]['description'];
      // print(weatherMessage);
      // print(weatherIcon);
      // print(cityName);
      // print(weatherData); //13.0653, 80.2427
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          var weatherData = weather.getLocationWeather();
                          updateUI(weatherData);
                        });
                        // print(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '$temperature°c',
                            style: kTempTextStyle,
                          ),
                          Text(
                            '$weatherIcon',
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '$weatherDescription',
                              style: kConditionMessageTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: Center(
                //     child: Text(
                //       '$cityName',
                //       style: kTempTextStyle,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 70.0),
                  child: Text(
                    " $weatherMessage in $cityName",
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

//
//// convertionKtoC(weatherTemperature);

/*
* Row(
                    children: [
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$weatherIcon',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
* */
