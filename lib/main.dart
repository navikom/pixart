import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixart/app.dart';
import 'package:pixart/locator.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  setupLocator();
  runApp(App());
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Welcome to Flutter'),
//         ),
//         body: Center(
//           child: Text('Hello World 2'),
//         ),
//       ),
//     );
//   }
// }
