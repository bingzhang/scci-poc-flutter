import 'package:flutter/material.dart';

class Alert {
  static Future<bool> showDialogResult(
      BuildContext builderContext, String message) async {
    bool alertDismissed = await showDialog(
      context: builderContext,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () =>
                    Navigator.pop(context, true)) //return dismissed 'true'
          ],
        );
      },
    );
    return alertDismissed;
  }
}
