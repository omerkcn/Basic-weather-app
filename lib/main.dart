import 'package:flutter/material.dart';
import 'package:weather_api/home.dart';
import 'package:provider/provider.dart';
//CURRENT WEATHER APP
//API TAKEN FROM OPENWEATHERMAP
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
