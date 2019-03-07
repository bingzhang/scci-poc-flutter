/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:swipedetector/swipedetector.dart';
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
    final AppLocalizations str = AppLocalizations.of(context);
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
                        headerText: str.studentScheduleEventHeader,
                        eventTime: str.studentScheduleEventTime,
                        eventDescription: str.studentScheduleEventDescription,
                        eventLocation: str.studentScheduleEventLocation,
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
              title: str.studentHomeButtonLifeCampus,
              gestureTapCallback: () => Navigator.pushNamed(context, '/student/campus'),
            ),
            HorizontalDivider(),
            RibbonButton(
              title:str.studentHomeButtonNewsEvent,
              gestureTapCallback:
                  () => Navigator.pushNamed(context, '/student/events'),
            ),
            SearchBar()
          ],
        ));
  }
}
