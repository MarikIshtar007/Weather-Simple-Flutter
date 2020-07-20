import 'package:flutter/material.dart';
import 'package:weathersimple/utility/weather_icon_mapper.dart';

IconData getIconData(String iconcode){
  switch(iconcode){
    case '01d':
    case '50d':
      return WeatherIcons.sun;
    case '01n' :
    case '50n':
      return WeatherIcons.moon;
    case '02d' :
    case '03d' :
      return WeatherIcons.sunCloud;
    case '02n' :
    case '03n' :
      return WeatherIcons.moonCloud;
    case '04d':
    case '04n' :
      return WeatherIcons.cloudy;
    case '09d' :
    case '09n' :
      return WeatherIcons.rain;
    case '10d':
    case '10n':
      return WeatherIcons.thunderRain;
    case '11d' :
    case '11n' :
      return WeatherIcons.thunder;
    case '50d':
    case '50n':
      return WeatherIcons.snow;
    default: return WeatherIcons.sunCloud;
  }
}