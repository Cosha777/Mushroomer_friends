import 'package:flutter/material.dart';

final theme = ThemeData(
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: Colors.white38,
      fontSize: 10,
    ),
  ),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(7, 20, 23, 1),
    centerTitle: true,
    toolbarHeight: 40,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(7, 20, 23, 1),
    selectedItemColor: Colors.orangeAccent,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontSize: 15),
    unselectedLabelStyle: TextStyle(fontSize: 11),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(7, 20, 23, 1),
  dialogTheme: const DialogTheme(
      backgroundColor: Colors.black,
      shadowColor: Colors.white,
      elevation: 10,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      )),
);
