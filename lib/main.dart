import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixart/app.dart';
import 'package:pixart/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  setupLocator();
  runApp(App());
}
