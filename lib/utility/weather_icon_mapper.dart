import 'package:flutter/material.dart';

class _IconData extends IconData{
  const _IconData(int code): super(
    code,
    fontFamily: 'WeatherIcons',
  );
}

class WeatherIcons{
  static const IconData sun = const _IconData(0xf00d);
  static const IconData cloudy = const _IconData(0xf013);
  static const IconData thunderRain = const _IconData(0xf01e);
  static const IconData rain = const _IconData(0xf019);
  static const IconData moon = const _IconData(0xf02e);
  static const IconData snow = const _IconData(0xf076);
  static const IconData moonCloud = const _IconData(0xf086);
  static const IconData sunCloud = const _IconData(0xf002);
  static const IconData thunder = const _IconData(0xf016);
  static const IconData sunrise = const _IconData(0xf046);
  static const IconData sunset = const _IconData(0xf047);
  static const IconData windSpeed = const _IconData(0xf011);

}
