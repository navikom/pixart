import 'package:flutter/material.dart';
import 'package:pixart/navigation/bottom_bar.dart';
import 'package:pixart/constants/routes_path.dart' as constants;
import 'package:pixart/screens/login/login_screen.dart';
import 'package:pixart/screens/login/registration_screen.dart';
import 'package:pixart/screens/pictures/picture_detail/picture_detail_screen.dart';
import 'package:pixart/screens/pictures/picture_screen.dart';
import 'package:pixart/store/pictures/picture.dart';
import 'package:provider/provider.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case constants.HOME_ROUTE:
      return MaterialPageRoute(builder: (context) => BottomBar());
    case constants.PICTURE_ROUTE:
      Picture picture = settings.arguments as Picture;
      return MaterialPageRoute(
        builder: (context) =>
            Provider<Picture>.value(value: picture, child: PictureScreen()),
      );
    case constants.PICTURE_DETAIL_ROUTE:
      Picture picture = settings.arguments as Picture;
      return MaterialPageRoute(
        builder: (context) => Provider<Picture>.value(
            value: picture, child: PictureDetailScreen()),
      );
    case constants.LOGIN_ROUTE:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case constants.REGISTRATION_ROUTE:
      return MaterialPageRoute(builder: (context) => RegistrationScreen());
    default:
      return MaterialPageRoute(builder: (context) => BottomBar());
  }
}
