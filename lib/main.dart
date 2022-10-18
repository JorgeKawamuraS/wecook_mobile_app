import 'package:flutter/material.dart';

import 'package:wecookmobile/bottomNavigation.dart';
import 'login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // textTheme: GoogleFonts.montserratTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        primarySwatch: Colors.brown,
      ),
      home: bottomNavigation(),
    );
  }
}

