import 'package:weathersimple/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:weathersimple/services/get_permission.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    checkForLocation();
    getData();
  }


  void getData() async{
    var weatherData = await weatherModel.getLocationWeather();
    String cityName = weatherData['name'];
    var forecastData = await weatherModel.getForecast(cityName);

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context){
        return HomeScreen(
          locationWeather: weatherData,
          forecastData: forecastData,
        );
      }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  'Make sure you have an Internet\n Connection and Location Turned on',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            CircularProgressIndicator(
              strokeWidth: 8.0,
              semanticsLabel: 'Loading..',
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}


