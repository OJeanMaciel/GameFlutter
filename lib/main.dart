// ignore: unused_import
import 'dart:async';
import 'package:appteste/phases/final.dart';
import 'package:appteste/phases/phasethree.dart';
import 'package:appteste/phases/phasetwo.dart';
import 'package:appteste/picture.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        'picture': (context) => Camera(),
        'phase': (context) => HomePage(),
        'phaseTwo': (context) => PhaseTwo(),        
        'phaseThree': (context) => PhaseThree(),           
        'final': (context) => Final(),
      },
    );
  }
}
