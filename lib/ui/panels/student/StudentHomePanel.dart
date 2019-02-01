/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:profile_demo/ui/navigation/NavigationRouter.dart';
import 'StudentUpToDateInfoPanel.dart';
import 'StudentEventsPanel.dart';
import 'StudentLifeInCampusPanel.dart';
import 'StudentSchedulePanel.dart';
import 'package:profile_demo/ui/panels/WebContentPanel.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/SearchBar.dart';
import 'package:profile_demo/ui/widgets/HorizontalDivider.dart';
import 'package:profile_demo/ui/widgets/Clock.dart';

class StudentHomePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SwipeDetector(
                onSwipeLeft:
                NavigationRouter.openPanel(context, StudentUpToDateInfoPanel()),
                onSwipeRight:
                NavigationRouter.openPanel(context, StudentSchedulePanel()),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new AssetImage(
                          "images/header_about.jpg",
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Clock(),
                          Expanded(child: Column()),
                          Column(children: <Widget>[
                            Image.asset('images/icon-weather.png',
                                width: 42, height: 42, fit: BoxFit.cover),
                            Text(
                              "30°F",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ]),
                        ],
                      ),
                      Expanded(child: Row(),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Good Morning, Alex!',
                            style: TextStyle(fontSize: 40),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Image.asset('images/icon-schedule.png',
                                    height: 50.0),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Next Event 9:30am',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('TE 401: Intro to Design Thinking'),
                                  Text('Noble Hall, Room 211')
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    'images/icon-time.png',
                    height: 62,
                    width: 62,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Time Until',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text('1 hr 20 min', style: TextStyle(fontSize: 32))
                    ],
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
              onTap: NavigationRouter.openPanel(context, StudentLifeOnCampusPanel()),
              child: Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Text(
                    'Life on Campus',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            GestureDetector(
              onTap: NavigationRouter.openPanel(context, StudentEventsPanel()),
              child: Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Text(
                    'News + Events',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            GestureDetector(
              onTap: NavigationRouter.openPanel(
                  context,
                  WebContentPanel(
                    url: 'https://fightingillini.com/',
                    title: 'Athletics',
                  )),
              child: Container(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Text(
                    'Athletics + Campus Venues',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            SearchBar()
          ],
        ));
  }
}
