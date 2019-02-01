/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

class EventPreview extends StatelessWidget {
  final String headerText;
  final String eventTime;
  final String eventDescription;
  final String eventLocation;

  EventPreview(
      {this.headerText,
      this.eventTime,
      this.eventDescription,
      this.eventLocation});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          headerText,
          style: TextStyle(fontFamily: 'Avenir', fontSize: 40),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Image.asset('images/icon-schedule.png', height: 50.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  eventTime,
                  style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold),
                ),
                Text(eventDescription, style: TextStyle(fontFamily: 'Avenir',)),
                Text(eventLocation, style: TextStyle(fontFamily: 'Avenir',))
              ],
            )
          ],
        )
      ],
    );
  }
}
