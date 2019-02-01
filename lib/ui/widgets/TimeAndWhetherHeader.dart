/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

import 'Clock.dart';

class TimeAndWhetherHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Clock(),
        Expanded(child: Column()),
        Column(children: <Widget>[
          Image.asset('images/icon-weather.png',
              width: 42, height: 42, fit: BoxFit.cover),
          Text(
            "43°F",
            style: TextStyle(color: Colors.black45),
          ),
        ]),
      ],
    );
  }
}
