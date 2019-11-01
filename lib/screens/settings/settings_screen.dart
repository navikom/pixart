import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixart/config/main_theme.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/service/navigation_service.dart';
import 'package:pixart/store/app_flow.dart';
import 'package:pixart/constants/routes_path.dart' as constants;

class SettingsScreen extends StatelessWidget {
  final AppFlow _store = locator<AppFlow>();
  final NavigationService _navigationService = locator<NavigationService>();

  Widget _user(BuildContext context) {
    return Observer(
      builder: (_) => ListTile(
          leading: Icon(Icons.person, color: IconTheme.of(context).color),
          title: Text(_store.user.anonymous ? "Login" : "Account"),
          trailing: Icon(Icons.arrow_right, color: IconTheme.of(context).color),
          onTap: () {
            _navigationService.navigateTo(constants.LOGIN_ROUTE);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Icon(Icons.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //1
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "General Setting",
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  _user(context),
                  ListTile(
                    leading: Icon(
                      Icons.sync,
                      color: buttonBlue,
                    ),
                    title: Text("Sync Data"),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: IconTheme.of(context).color,
                    ),
                  )
                ],
              ),
            ),
            //2
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Sound",
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.do_not_disturb_off,
                      color: vividOrangePeel,
                    ),
                    title: Text("Silent Mode"),
                    trailing: Switch(
                      value: false,
                      onChanged: (_) {},
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.volume_up,
                      color: slimyGreen,
                    ),
                    title: Text("Sound Volume"),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: IconTheme.of(context).color,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.phonelink_ring,
                      color: IconTheme.of(context).color,
                    ),
                    title: Text("Ringtone"),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: IconTheme.of(context).color,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
