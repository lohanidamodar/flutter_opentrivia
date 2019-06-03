import 'package:flutter/material.dart';
import 'package:opentrivia/ui/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Trivia',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.indigo,
        fontFamily: "Montserrat"
      ),
      home: HomePage(),
    );
  }
}
