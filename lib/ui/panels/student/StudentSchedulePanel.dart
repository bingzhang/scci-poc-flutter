/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

class StudentSchedulePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('SAVVI'),
        ),
        body: Column(
          children: <Widget>[Text('Slide 7 left panel')],
        ));
  }
}
