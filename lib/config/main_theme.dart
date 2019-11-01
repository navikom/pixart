import 'package:flutter/material.dart';

final Color amber = Color(0xFFFFC200);
final Color vividOrangePeel = Color(0xFFFEA002);
final Color darkCerulean = Color(0xFF174B7D);
final Color buttonBlue = Color(0xFF19A3EB);
final Color alienArmpit = Color(0xFF67DD0B);
final Color slimyGreen = Color(0xFF25A800);

final Color textTitleColor = vividOrangePeel;
final Color bgNavColor = Color.fromRGBO(93, 142, 155, 1.0);
final Color bgNavLightColor = Color.fromRGBO(170, 207, 211, 1.0);

ThemeData theme = ThemeData(
  primaryColor: buttonBlue,
  accentColor: alienArmpit,
  fontFamily: 'Brandon Grotesque',
  scaffoldBackgroundColor: Color(0xffffffff),
  buttonColor: alienArmpit,
  dividerColor: bgNavColor,
  splashColor: darkCerulean,
  iconTheme: IconThemeData(
    color: darkCerulean,
    size: 36.0,
  ),
  appBarTheme: AppBarTheme(
    color: bgNavColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: alienArmpit,
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
