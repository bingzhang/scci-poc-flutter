/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';

import 'Clock.dart';

class TimeAndWhetherHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Clock(),
        Expanded(child: Column()),
        Column(children: <Widget>[
          Semantics(
            label: AppLocalizations.of(context).semanticsWeatherLabel,
            child: Image.asset('images/icon-weather.png',
                width: 42, height: 42, fit: BoxFit.cover),
          ),
          Text(
            "43°F",
            style: TextStyle(
                fontFamily: 'Avenir', fontSize: 12, color: Colors.black45),
          ),
        ]),
      ],
    );
  }
}
