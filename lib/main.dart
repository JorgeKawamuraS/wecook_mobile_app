import 'package:flutter/material.dart';

import 'package:wecookmobile/bottomNavigation.dart';
import 'login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),  //code
        Locale('es', ''), // arabic, no country code
      ],
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.brown,
      ),
      home: bottomNavigation(chips: []),
    );
  }
}

