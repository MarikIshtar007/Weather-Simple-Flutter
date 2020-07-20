import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Simple',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat', highlightColor: Colors.white70),
      home: LoadingScreen(),
    );
  }
}
