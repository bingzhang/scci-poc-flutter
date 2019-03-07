/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/utility/Utils.dart';

class EventPreview extends StatelessWidget {
  final String headerText;
  final String eventTime;
  final String eventDescription;
  final String eventLocation;
  final GestureTapCallback onTap;

  EventPreview(
      {this.headerText,
      this.eventTime,
      this.eventDescription,
      this.eventLocation,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildWidgets(context)),
    );
  }

  List<Widget> _buildWidgets(BuildContext context) {
    List<Widget> widgets = List();
    if (!AppUtils.isStringEmpty(headerText)) {
      Text headerView = Text(
        headerText,
        style: TextStyle(fontFamily: 'Avenir', fontSize: 40),
      );
      widgets.add(headerView);
    }
    Row row = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Semantics(
            excludeSemantics: true,
            label: AppLocalizations.of(context).semanticsEventPreviewLabel,
            image: true,
            child: Image.asset('images/icon-schedule.png', height: 50.0),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              eventTime,
              style:
                  TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold),
            ),
            Text(eventDescription,
                style: TextStyle(
                  fontFamily: 'Avenir',
                )),
            Text(eventLocation,
                style: TextStyle(
                  fontFamily: 'Avenir',
                ))
          ],
        )
      ],
    );
    widgets.add(row);
    return widgets;
  }
}
