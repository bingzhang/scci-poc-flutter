/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'StudentCampusPanel.dart';
import 'StudentSchedulePanel.dart';

class StudentHomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SAVVI'),
        ),
        body: Column(
          children: <Widget>[
            Text('Slide 6 panel'),
            SwipeDetector(
              child: Container(height: 300, width: 300, color: Colors.red),
              onSwipeLeft: _openCampusPanel(context),
              onSwipeRight: _openSchedulePanel(context),
            )
          ],
        ));
  }

  Function _openCampusPanel(BuildContext context) {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => StudentCampusPanel()));
    };
  }

  Function _openSchedulePanel(BuildContext context) {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => StudentSchedulePanel()));
    };
  }
}
