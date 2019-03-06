/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/logic/EventsLogic.dart';
import 'package:profile_demo/ui/page_routers/SlidePanelRoute.dart';
import 'package:profile_demo/ui/panels/WebContentPanel.dart';
import 'package:profile_demo/ui/panels/student/StudentSchedulePanel.dart';
import 'package:profile_demo/ui/panels/student/StudentUpToDateInfoPanel.dart';
import 'package:profile_demo/ui/widgets/EventPreview.dart';
import 'package:profile_demo/ui/widgets/NextEventDetails.dart';
import 'package:profile_demo/ui/widgets/RibbonButton.dart';
import 'package:profile_demo/ui/widgets/TimeAndWhetherHeader.dart';
import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/HorizontalDivider.dart';
import 'package:profile_demo/ui/widgets/SearchBar.dart';
import 'package:profile_demo/utility/Utils.dart';

class StudentHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    return Scaffold(
        appBar: HeaderAppBar(context: context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SwipeDetector(
                onSwipeLeft: _onSwipeLeft(context),
                onSwipeRight: _onSwipeRight(context),
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
                        headerText: localizations.studentHomeGoodMorningText,
                        eventTime: localizations.studentHomeEventTime,
                        eventDescription: localizations.studentHomeEventDescription,
                        eventLocation: localizations.studentHomeEventLocation,
                      )
                    ],
                  ),
                ),
              ),
            ),
            HorizontalDivider(),
            NextEventDetails(),
            HorizontalDivider(),
            RibbonButton(
              title: localizations.studentHomeButtonLifeCampus,
              gestureTapCallback: () =>
                  Navigator.pushNamed(context, '/student/campus'),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: localizations.studentHomeButtonNewsEvent,
              gestureTapCallback: () =>
                  Navigator.pushNamed(context, '/student/events'),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: localizations.studentHomeButtonAthletics,
              gestureTapCallback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebContentPanel(
                          url: 'https://fightingillini.com/',
                          title: localizations.studentHomeButtonAthleticsActionHeader))),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: localizations.studentHomeButtonMaps,
              gestureTapCallback: () =>
                  _launchIndoorMaps(),
            ),
            HorizontalDivider(),
            SearchBar()
          ],
        ));
  }

  Function _onSwipeLeft(BuildContext context) {
    return () => Navigator.push(
        context,
        SlidePanelRoute(
            widget: StudentUpToDateInfoPanel(), animateLeft: true));
  }

  Function _onSwipeRight(BuildContext context) {
    return () => Navigator.push(
        context, SlidePanelRoute(widget: StudentSchedulePanel()));
  }

  _launchIndoorMaps() async {
    List<dynamic> events = EventsLogic().getAllEvents();
    String eventsString = (events != null) ? json.encode(events) : null;
    try {
      await AppConstants.platformChannel.invokeMethod(
          'indoorMaps', {"events": eventsString});
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

}
