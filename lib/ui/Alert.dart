import 'package:flutter/material.dart';

class Alert {

  static void showDialogResult(BuildContext builderContext, String message) {
    showDialog(
      context: builderContext,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      },
    );
  }
}