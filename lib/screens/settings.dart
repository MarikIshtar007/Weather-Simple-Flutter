import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weathersimple/services/weather.dart';
import 'home_screen.dart';

class Settings extends StatefulWidget {

  final weatherState;

  const Settings({Key key, @required this.weatherState}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    var currentWeatherState = widget.weatherState;
    TempUnit _currentTempUnit = currentWeatherState.getUnit();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Text(
                "Settings",
                style: TextStyle(color: Colors.white)
            ),
          ),
        ),
        body: Container(
          color: Color(0xFF191B26),
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.white,
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white24,
                  ),
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Temperature',
                    style: TextStyle(color: Colors.white,
                      fontSize: 18.0,)
                  ),
                ),
                RadioListTile(
                  title: Text(
                      'Celsius',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  groupValue: _currentTempUnit,
                  value: TempUnit.metric,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (TempUnit value){
                    setState(() {
                      currentWeatherState.setUnit(value);
                    });
                  },
                ),
                RadioListTile(
                  title: Text(
                      'Fahrenheit',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  groupValue: _currentTempUnit,
                  value: TempUnit.imperial,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (TempUnit value){
                    setState(() {
                      currentWeatherState.setUnit(value);
                    });
                  },
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
