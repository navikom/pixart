import 'package:flutter/material.dart';

final Color amber = Color(0xFFFFC200);
final Color vividOrangePeel = Color(0xFFFEA002);
final Color darkCerulean = Color(0xFF174B7D);
final Color buttonBlue = Color(0xFF19A3EB);
final Color alienArmpit = Color(0xFF67DD0B);
final Color slimyGreen = Color(0xFF25A800);

final Color textTitleColor = vividOrangePeel;

ThemeData theme = ThemeData(
  primaryColor: buttonBlue,
  accentColor: alienArmpit,
  fontFamily: 'Brandon Grotesque',
  scaffoldBackgroundColor: Color(0xffffffff),
  buttonColor: alienArmpit,
  dividerColor: vividOrangePeel.withAlpha(100),
  splashColor: darkCerulean,
  iconTheme: IconThemeData(
    color: textTitleColor,
    size: 100.0,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: textTitleColor,
      size: 35,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        fontFamily: 'Brandon Grotesque',
        fontSize: 24.0,
        color: textTitleColor,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: alienArmpit,
  ),
  textTheme: TextTheme(
    title: TextStyle(color: textTitleColor),
  ),
);
