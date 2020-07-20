import 'package:flutter/material.dart';

class Tile extends StatelessWidget {

  final String time;
  final IconData icondata;
  final String temp;
  final String tempMin;
  final String tempMax;

  Tile({this.time, this.icondata, this.temp, this.tempMin, this.tempMax});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.time,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        SizedBox(
          height: 5,
        ),
        this.icondata != null
        ?Icon(
          icondata,
          color: Colors.white,
          size: 20,
        )
            : Text(''),
        SizedBox(
          height: 10,
        ),
        Text(
          this.temp,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          this.tempMin,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          this.tempMax,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
