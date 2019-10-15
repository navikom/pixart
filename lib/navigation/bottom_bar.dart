import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixart/screens/pictures/pictures_pages.dart';
import 'package:pixart/screens/settings_screen.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Theme.of(context).bottomAppBarTheme.color,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
              )
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return Material(child: PicturesPages());
              case 1:
                return Material(child: SettingsScreen());
            }
            return null;
          },
        ),
      ),
    );
  }
}
