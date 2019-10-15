import 'package:flutter/material.dart';

void show(
  BuildContext context,
  String title,
  var message,
  List<Widget> actions,
) {
  if (actions == null) {
    actions = [];
    actions.add(
      FlatButton(
        child: Text('OK'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: message is String ? Text(message) : message,
      actions: actions,
    ),
  );
}
