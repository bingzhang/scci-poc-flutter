/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';

class NextEventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Semantics(
            excludeSemantics: true,
            hint: localizations.nextEventTimeHint,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    'images/icon-time.png',
                    height: 62,
                    width: 62,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        localizations.nextEventTimeUntilLabel,
                        style: TextStyle(fontSize: 18, fontFamily: 'Avenir'),
                      ),
                      Text(localizations.nextEventTimeLabel,
                          style: TextStyle(fontSize: 30, fontFamily: 'Avenir'))
                    ],
                  ),
                ])),
        Semantics(
          excludeSemantics: true,
          hint: localizations.nextEventAlarmHint,
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/icon-clock.png',
                height: 50,
              ),
              Text(
                "15"+localizations.min,
                style: TextStyle(fontFamily: 'Avenir'),
              )
            ],
          ),
        ),
        Semantics(
          excludeSemantics: true,
          hint: localizations.nextEventBycycleHint,
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/icon-bycicle.png',
                height: 50,
              ),
              Text(
                "7"+ localizations.min,
                style: TextStyle(fontFamily: 'Avenir'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
