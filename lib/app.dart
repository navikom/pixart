import 'package:flutter/material.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/navigation/router.dart' as router;
import 'package:pixart/service/navigation_service.dart';
import 'package:pixart/store/app_flow.dart';
import 'package:pixart/constants/routes_path.dart' as constants;
import 'package:pixart/config/main_theme.dart' as config;

class App extends StatelessWidget {
  final AppFlow store = locator<AppFlow>();
  App() {
    store.start();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: config.theme,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        initialRoute: constants.HOME_ROUTE);
  }
}
