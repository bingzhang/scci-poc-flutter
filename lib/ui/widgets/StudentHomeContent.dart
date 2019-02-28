/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:swipedetector/swipedetector.dart';
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

class StudentHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        headerText: AppLocalizations.of(context).studentHomeGoodMorningText,
                        eventTime: 'Next Event 9:30am',
                        eventDescription: 'TE 401: Intro to Design Thinking',
                        eventLocation: 'Noble Hall, Room 211',
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
              title: 'Life on Campus',
              gestureTapCallback: () =>
                  Navigator.pushNamed(context, '/student/campus'),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: 'News + Events',
              gestureTapCallback: () =>
                  Navigator.pushNamed(context, '/student/events'),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: 'Athletics + Campus Venues',
              gestureTapCallback: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebContentPanel(
                          url: 'https://fightingillini.com/',
                          title: 'Athletics'))),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: 'Indoor Maps',
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

   static const platform = const MethodChannel("com.uiuc.profile/native_call");
  _launchIndoorMaps() async {
    try {
      String userName = ProfileLogic()?.getUser()?.name;
      await platform.invokeMethod('indoorMaps',{"user_name":userName});
    } on PlatformException catch (e) {
      print(e.message);
    } 
}

}
