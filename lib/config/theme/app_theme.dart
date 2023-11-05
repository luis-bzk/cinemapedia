import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final bool isDarkMode;

  AppTheme({this.isDarkMode = false});

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorList[0],
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(centerTitle: false));
}
