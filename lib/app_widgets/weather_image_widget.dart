import 'package:flutter/material.dart';
import 'package:weathersimple/screens/home_screen.dart';
import 'dart:math' as math;
import 'package:weathersimple/utility/weather_icon_mapper.dart';

class WeatherImage extends StatefulWidget {

  final wip imgPrompt;
  WeatherImage({@required this.imgPrompt});
  @override
  _WeatherImageState createState() => _WeatherImageState();
}

class _WeatherImageState extends State<WeatherImage> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 10))..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    wip imagePrompt = widget.imgPrompt;

    switch(imagePrompt){
      case wip.sun : return AnimatedBuilder(
        animation: _controller,
        builder: (_, child){
          return Transform.rotate(angle: _controller.value* math.pi,
            child: child,
          );
        },
        child: Icon(
            WeatherIcons.sun,
          color: Colors.white,
          size: 180.0,
        ),
      );
      case wip.sunCloud : return Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned(
            child: Image.asset(
              'images/single_cloud.png',
              width: 250,
              height: 250,
            ),
          ),
          Positioned(
            right: 45.0,
            top: 56.0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child){
                return Transform.rotate(angle: _controller.value* math.pi,
                  child: child,
                );
              },
              child: Image.asset(
                'images/sun3.png',
                width: 200,
                height: 200,
              ),
            ),
          ),
        ],
      );
      case wip.moon : return MyImage(url: 'images/moon.png',);
      case wip.moonCloud : return MyImage(url: 'images/cloud_moon.png',);
      case wip.snow : return MyImage(url: 'images/snow.png',);
      case wip.rain : return Icon(WeatherIcons.rain, color: Colors.white, size: 200,);
      case wip.clouds : return Icon(WeatherIcons.cloudy, color: Colors.white, size: 220);
      case wip.thunder : return MyImage(url: 'images/thunder.png');
      case wip.thunderRain : return Icon(WeatherIcons.thunderRain, color: Colors.white, size:190);
      default : return AnimatedBuilder(
        animation: _controller,
        builder: (_, child){
          return Transform.rotate(angle: _controller.value* math.pi,
            child: child,
          );
        },
        child: Icon(
          WeatherIcons.sun,
          color: Colors.white,
          size: 180.0,
        ),
      );
    }
  }

}

class MyImage extends StatelessWidget {
  MyImage({@required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      width: 210.0,
      height: 210.0,
    );
  }
}



