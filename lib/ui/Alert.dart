/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';

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
                child: Text(AppLocalizations.of(context).ok),
                onPressed: () =>
                    Navigator.pop(context, true)) //return dismissed 'true'
          ],
        );
      },
    );
    return alertDismissed;
  }
}
