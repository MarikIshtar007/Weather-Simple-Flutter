import 'package:flutter/material.dart';
import 'package:weathersimple/services/weather.dart';
import 'package:flutter/services.dart';
import 'package:weathersimple/app_widgets/weather_image_widget.dart';
import 'package:weathersimple/utility/weather_icon_mapper.dart';
import 'package:weathersimple/app_widgets/search_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:weathersimple/app_widgets/forecast_widget.dart';
import 'package:intl/intl.dart';

enum wip {
  sun,
  moon,
  rain,
  thunder,
  thunderRain,
  snow,
  sunCloud,
  moonCloud,
  clouds
}

enum OptionMenu{
  searchCityWeather,
  aboutApp,
}

class HomeScreen extends StatefulWidget {

  final locationWeather;
  final forecastData;
  HomeScreen({this.locationWeather, this.forecastData});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageController _pageController;

  var _forecast;

  final days = <int, String>{
    1 : 'Monday',
    2 : 'Tuesday',
    3 : 'Wednesday',
    4 : 'Thursday',
    5 : 'Friday',
    6 : 'Saturday',
    7 : 'Sunday'
  };

  final months = <int, String>{
    1 : 'Jan',
    2 : 'Feb',
    3 : 'Mar',
    4 : 'Apr',
    5 : 'May',
    6 : 'Jun',
    7 : 'Jul',
    8 : 'Aug',
    9 : 'Sep',
    10 : 'Oct',
    11 : 'Nov',
    12 : 'Dec'
  };

  String _totalDate;
  WeatherModel wmdl = WeatherModel();
  String celsius = '';
  String cel_feels = '';
  String weatherIcon;
  String cityName;
  String country;
  int condition;
  Color _color1;
  Color _color2;
  int hour;
  String today;
  String conditionDisplayText;
  wip imageURL;
  String sunriseTime;
  String sunsetTime;
  String windSpeed;

  @override
  void initState() {
    updateInfo(widget.locationWeather);
    updateForecastData(widget.forecastData);
    _pageController = PageController(initialPage: 1,);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  void updateInfo(dynamic weatherData) {
    setState(() {
      if(weatherData == null){
        weatherIcon = 'Error';
        cityName = '';
        condition = 0;
        country = '';
        imageURL = wip.sun;
        return;
      }

      int temp = weatherData['main']['temp'].toInt();
      celsius = temp.toString();
      int temp2 = weatherData['main']['feels_like'].toInt();
      cel_feels = temp2.toString();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      country = weatherData['sys']['country'];
      conditionDisplayText = weatherData['weather'][0]['main'];
      var dt = DateTime.fromMillisecondsSinceEpoch(weatherData["dt"]*1000);
      today = days[dt.weekday];
      hour = dt.hour;
      _totalDate = '${dt.day} ${months[dt.month]}, ${dt.year}';
      print(_totalDate);
      sunriseTime = DateFormat('E, ha').format(DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise']*1000));
      sunsetTime = DateFormat('E, ha').format(DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset']*1000));
      windSpeed = weatherData["wind"]["speed"].toString();
    });
  }


  void updateForecastData(dynamic forecastData){
    _forecast = forecastData;
  }


  void updateUIColor(int hour, int condition) {
    String first = condition.toString()[0];
    if (condition == 800 || first == '7') {// Clear Sky
      if (hour >= 6 && hour <= 10) {
        // Morning - Sun
        imageURL = wip.sun;
        _color1 = Color(0x22FBB03F);
        _color2 = Color(0xFFFFDE14);
      } else if (hour >= 11 && hour <= 18){
        // Afternoon - Sun
        imageURL= wip.sun;
        _color1 = Colors.lightBlueAccent;
        _color2 = Colors.lightBlue;
    } else {
        imageURL = wip.moon;
        // Evening + Night - Moon
        _color1 = Colors.black12;
        _color2 = Colors.black87;
    }
  }
    else if(condition > 802 ){// Cloudy
      //full clouds
      imageURL = wip.clouds;
      if(hour>=6 && hour<=18){ // cloudy + Day
        _color1 = Color(0xAADDE2E5);
        _color2 = Color(0xFF95A1AC);
      }
      else{
        _color1 = Colors.black12;
        _color2 = Colors.black38;
      }
    }
    else if(condition > 800 && condition<=802 ){// Cloudy
      if(hour>=6 && hour<=18){ // cloudy + Day
        imageURL = wip.sunCloud;
        _color1 = Color(0xAADDE2E5);
        _color2 = Color(0xFF95A1AC);
      }
      else{
        imageURL = wip.moonCloud;
        _color1 = Colors.black12;
        _color2 = Colors.black38;
      }

    }
    else if(condition >= 200 && condition <=622 ){// Thunderstorm
      if(first == '2'){
        _color1 = Color(0x44662E93);
        _color2 = Color(0xFF95258E);
        if (condition<=210){
          imageURL = wip.thunder;
        }
        else{
          imageURL = wip.thunderRain;
        }
      }
      else if( first == '3' || first== '5'){
        imageURL = wip.rain;
        _color1 = Color(0xFFDDE2E5);
        _color2 = Color(0xFF95A1AC);
      }
      else if(first == '6'){
        imageURL = wip.snow;
        _color1 = Colors.white30;
        _color2 = Colors.white70;
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    updateUIColor(hour, condition);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        elevation:  0.0,
        title: Center(child: Text('Weather Simple'),),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          tooltip: 'Get Current Location',
          icon: Icon(Icons.my_location),
          onPressed: () async{
            var weatherData = await wmdl.getLocationWeather();
            var forecastData = await wmdl.getForecast(cityName);
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(
                    'Weather is being updated',
                    style: TextStyle(
                        foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.white,
                    ),
                  ),
                  backgroundColor: _color2,
                  duration: Duration(seconds: 2),
                  elevation: 3.0,
                )
            );
            updateInfo(weatherData);
            updateForecastData(forecastData);
            updateUIColor(hour, condition);
          },
        ),
        actions: <Widget>[
          PopupMenuButton<OptionMenu>(
            tooltip: 'More Options',
            child: Icon(Icons.more_vert,),
            onSelected: this._onOptionSelected,
            itemBuilder: (context){
              var list = List<PopupMenuEntry<OptionMenu>>();
              list.add(
                PopupMenuItem<OptionMenu>(
                  value: OptionMenu.searchCityWeather,
                  height: 30.0,
                  child: Text('Change City'),
                ),
              );
              list.add(
                PopupMenuDivider(
                  height: 10.0,
                )
              );
              list.add(
                  PopupMenuItem<OptionMenu>(
                    value: OptionMenu.aboutApp,
                    height: 30.0,
                    child: Text('About App'),
                  )
              );
              return list;
            }
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ _color1, _color2]
            )
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: <Widget>[
                              Transform.translate(
                                child: Text(
                                  today,
                                  style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )
                                ),
                                offset: Offset(-10, 0)
                              ),
                              Text(
                                _totalDate,
                                style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Swiper(
                          itemCount: 2,
                          index: 0,
                          itemBuilder: (context, index){
                            if (index == 0){
                              return Padding(
                                padding: const EdgeInsets.only(top: 5.0, bottom: 40.0, right: 20.0, left: 20.0),
                                child: WeatherImage(imgPrompt: imageURL),
                              );
                            }else if(index == 1){
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: _color2.withOpacity(0.3)
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text('Sunrise', style: TextStyle(color: Colors.white),),
                                              Icon(
                                                WeatherIcons.sunrise,
                                                color: Colors.yellowAccent,
                                                size: 30.0,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                sunriseTime,
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                  'Sunset',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              Icon(
                                                WeatherIcons.sunset,
                                                color: Colors.orangeAccent,
                                                size: 30.0,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                sunsetTime,
                                                style: TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                'Wind Speed',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              Icon(
                                                WeatherIcons.windSpeed,
                                                color: Colors.white,
                                                size: 30.0,
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                  '$windSpeed m/sec',
                                                  style: TextStyle(color: Colors.white)
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Text('Forecast', style: TextStyle(color: Colors.white, fontSize: 15.0)),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Divider(color: Colors.white,height: 1.0,thickness: 1.0,indent: 10.0, endIndent: 10.0,),
                                    Flexible(
                                      flex: 2,
                                      child: Forecast_Horizontal_Widget(forecastData: _forecast)
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Text('Something went wrong');
                          },
                          pagination: SwiperPagination(
                            margin: EdgeInsets.all(5),
                            builder: DotSwiperPaginationBuilder(
                              size: 5,
                              activeSize: 8,
                              color: Colors.white.withOpacity(0.3),
                              activeColor: Colors.white
                            )
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 45.0),
                                      children: <TextSpan>[
                                        TextSpan(text: '$celsius°'),
                                        TextSpan(text:'C', style: TextStyle(fontSize: 30.0))
                                      ]
                                  ),
                                ),
                              ),
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.white),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Feels like ', style: TextStyle(fontSize: 14.0)),
                                      TextSpan(text: '$cel_feels°', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold))
                                    ]
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                     VerticalDivider(
                          color: Colors.white70,
                          width: 2,
                          thickness: 1,
                       endIndent: 35,
                        ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  conditionDisplayText,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                child: Text(
                                  '$cityName, $country',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
          ),
        ),
      );
  }

  void searchingCity() async{
    var stateCountry = await showSearch(context: context, delegate: CitySearch());
    var combo = stateCountry.split(',');
    var city = combo[0];
    var country = combo[1].replaceAll(' ', '+');
    var weatherData = await wmdl.getCityWeather('$city,$country');
    var forecastData = await wmdl.getForecast(city);
    print('the forecast data for $city is $forecastData');
    setState(() {
      updateInfo(weatherData);
      updateForecastData(forecastData);
      updateUIColor(hour, condition);
    });

  }

  void _onOptionSelected(OptionMenu item){
    switch(item){
      case OptionMenu.searchCityWeather:
        searchingCity();
        break;
      case OptionMenu.aboutApp:
        showAboutDialog(
          applicationName: 'Weather Simple',
          context: context,
          applicationIcon: Image.asset('images/logo.png', width: 40.0,),
          applicationVersion: '1.0.5',
          children: [
            Text(creditText),
          ]
        );
        break;
    }
  }
}

