import 'package:flutter/material.dart';
import 'package:sqfliteapp/pages/login/login_page.dart';

import 'pages/home_page.dart';

void main() => runApp(new MyApp());

final routes = {
  "/login" : (BuildContext context) => LoginPage(),
  "/home" : (BuildContext context) => HomePage(),
  "/" : (BuildContext context) => LoginPage()
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      title: "Sqflite App",
      theme: new ThemeData(
        primarySwatch: Colors.teal
      ),
    );
  }
}
