/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'StudentCampusPanel.dart';
import 'StudentSchedulePanel.dart';
import 'StudentEventsPanel.dart';
import 'package:profile_demo/ui/panels/WebContentPanel.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/HorizontalDivider.dart';

class StudentHomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),
        body: ListView(
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: SwipeDetector(
                child: Image.asset(
                  'images/header_about.jpg',
                  fit: BoxFit.cover,
                  height: 380,
                ),
                onSwipeLeft: _openPanel(context, StudentCampusPanel()),
                onSwipeRight: _openPanel(context, StudentSchedulePanel()),
              ),
            ),
            HorizontalDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(
                    'images/icon-time.png',
                    height: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('Time Until'), Text('1 hr 20 min')],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'images/icon-clock.png',
                        height: 50,
                      ),
                      Text('15 min')
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'images/icon-bycicle.png',
                        height: 50,
                      ),
                      Text('7 min')
                    ],
                  ),
                ),
              ],
            ),
            HorizontalDivider(),
            GestureDetector(
              onTap: _openPanel(context, StudentCampusPanel()),
              child: Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                  child: Text(
                    'Life on Campus',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            GestureDetector(
              onTap: _openPanel(context, StudentEventsPanel()),
              child: Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                  child: Text(
                    'News + Events',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            GestureDetector(
              onTap: _openPanel(
                  context,
                  WebContentPanel(
                    url: 'https://fightingillini.com/',
                    title: 'Athletics',
                  )),
              child: Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                  child: Text(
                    'Athletics + Campus Venues',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                    width: double.infinity,
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              flex: 1,
                              child: Image.asset('images/icon-settings.png')),
                          Flexible(flex: 1, child: TextFormField()),
                          Flexible(
                              flex: 1,
                              child: Image.asset('images/icon-search.png'))
                        ],
                      ),
                    ),
                  ),
            ),
          ],
        ));
  }

  Function _openPanel(BuildContext context, Widget panel) {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => panel));
    };
  }
}
