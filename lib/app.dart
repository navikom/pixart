import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/navigation/router.dart' as router;
import 'package:pixart/service/localization/localizations.dart';
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
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en', 'US')
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        theme: config.theme,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        initialRoute: constants.HOME_ROUTE);
  }
}
