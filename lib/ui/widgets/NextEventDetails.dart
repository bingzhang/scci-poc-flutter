/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

class NextEventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Semantics(
          excludeSemantics: true,
          hint: "1 hr 20 min until the event",
          child:Row(children: <Widget>[
            Image.asset(
              'images/icon-time.png',
              height: 62,
              width: 62,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Time Until',
                    style: TextStyle(fontSize: 18, fontFamily: 'Avenir'),
                  ),
                  Text('1 hr 20 min',
                      style: TextStyle(fontSize: 30, fontFamily: 'Avenir'))
                ],
              ),
            ),
        ])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Semantics(
            excludeSemantics: true,
            hint: "15 minutes to alarm",
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/icon-clock.png',
                  height: 50,
                ),
                Text(
                  '15 min',
                  style: TextStyle(fontFamily: 'Avenir'),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Semantics(
            excludeSemantics: true,
            hint: "7 minutes to bycycle",
            child: Column(
              children: <Widget>[
                Image.asset(
                  'images/icon-bycicle.png',
                  height: 50,
                ),
                Text(
                  '7 min',
                  style: TextStyle(fontFamily: 'Avenir'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
