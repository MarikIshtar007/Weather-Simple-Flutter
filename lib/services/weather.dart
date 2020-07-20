import 'location_coord.dart';
import 'networking.dart';

const apiKey = '_API_KEY_HERE_';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/';
const creditText = 'This minimal app was developed by Haany Ali, using the Flutter UI toolkit.';

enum TempUnit {
  metric,
  imperial
}

class WeatherModel{

  String _units = 'metric';
  String _isCity = '';
  double _lat=0.0;
  double _lon=0.0;

  TempUnit getUnit(){
    if (_units == 'imperial'){
      return TempUnit.imperial;
    }
    else{
      return TempUnit.metric;
    }
  }

  void setUnit(TempUnit givenUnit){
    if (givenUnit == TempUnit.imperial){
      _units = 'imperial';
    }
    else{
      _units = 'metric';
    }
  }

  Future<dynamic> getCityWeather(String cityName) async{
    _isCity = cityName;
    NetworkHelper networkHelper = NetworkHelper(
      url: '$openWeatherMapURL/weather?q=$cityName&appid=$apiKey&units=metric'
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  Future<dynamic> getLocationWeather() async{
    _isCity = '';
    LocationCoords location = LocationCoords();
    await location.getCurrentLocation();
    _lat =location.Latitude;
    _lon = location.Longitude;

    NetworkHelper networkHelper = NetworkHelper(
      url: '$openWeatherMapURL/weather?lat=${location.Latitude}&lon=${location.Longitude}&appid=$apiKey&units=metric'
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getForecast(String cityName) async{
      NetworkHelper networkHelper = NetworkHelper(
        url: '$openWeatherMapURL/forecast?q=$cityName&appid=$apiKey&units=metric'
      );
      var weatherData = await networkHelper.getData();
      return weatherData;
    }
}

