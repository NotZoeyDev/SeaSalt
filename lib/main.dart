/*
  App main file
  By @ZoeyLovesMiki, 2019
*/
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(SeaSalt());

class SeaSalt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeaSalt',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff00416a)
      ),
      home: HomePage()
    );
  }
}