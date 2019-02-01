/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:profile_demo/ui/navigation/NavigationRouter.dart';
import 'package:profile_demo/ui/panels/student/StudentLifeInCampusPanel.dart';
import 'package:profile_demo/ui/panels/student/StudentEventsPanel.dart';
import 'package:profile_demo/ui/widgets/EventPreview.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/HorizontalDivider.dart';
import 'package:profile_demo/ui/widgets/NextEventDetails.dart';
import 'package:profile_demo/ui/widgets/RibbonButton.dart';
import 'package:profile_demo/ui/widgets/SearchBar.dart';
import 'package:profile_demo/ui/widgets/TimeAndWhetherHeader.dart';

class StudentSchedulePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SwipeDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images/header_about.jpg",
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop)),
                  ),
                  child: Column(
                    children: <Widget>[
                      TimeAndWhetherHeader(),
                      Expanded(
                        child: Row(),
                      ),
                      EventPreview(
                        headerText: 'Ready for Lunch?',
                        eventTime: 'Next Event 1:00pm',
                        eventDescription: 'ARTD 202: ID Studio II',
                        eventLocation: 'Art + Design, Room 25',
                      )
                    ],
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            NextEventDetails(),
            HorizontalDivider(),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/icon-clock.png',
                      height: 62,
                      width: 62,
                    ),
                    Image.asset(
                      'images/icon-walk.png',
                      height: 62,
                      width: 62,
                    ),
                    Image.asset(
                      'images/icon-bycicle.png',
                      height: 62,
                      width: 62,
                    ),
                    Image.asset(
                      'images/icon-bus.png',
                      height: 62,
                      width: 62,
                    ),
                    Image.asset(
                      'images/icon-car.png',
                      height: 62,
                      width: 62,
                    ),
                  ],
                )),
            HorizontalDivider(),
            RibbonButton(
              title: 'Life on Campus',
              gestureTapCallback: NavigationRouter.openPanel(
                  context, StudentLifeOnCampusPanel()),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: 'News + Events',
              gestureTapCallback:
                  NavigationRouter.openPanel(context, StudentEventsPanel()),
            ),
            SearchBar()
          ],
        ));
  }
}
