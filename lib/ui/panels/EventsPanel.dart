/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/logic/EventsLogic.dart';
import 'package:profile_demo/ui/widgets/EventPreview.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:intl/intl.dart';

class EventsPanel extends StatefulWidget {
  final String title;

  EventsPanel({Key key, this.title}) : super(key: key);

  @override
  _EventsPanelState createState() => _EventsPanelState(title);
}

class _EventsPanelState extends State<EventsPanel> {
  final panelTitle;

  _EventsPanelState(this.panelTitle) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(panelTitle),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: _buildListView())),
    );
  }

  Widget _buildListView() {
    AppLocalizations localizations = AppLocalizations.of(context);
    List<dynamic> events = EventsLogic().getAllEvents();
    int eventsCount = (events != null) ? events.length : 0;
    if (eventsCount > 0) {
      return ListView.separated(
        separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.black,
              ),
            ),
        itemCount: eventsCount,
        itemBuilder: (context, index) {
          Map<String, dynamic> event = events[index];
          String eventName = event['name'];
          String eventTimeString = event['time'];
          DateFormat serverDateFormat = DateFormat('yyyy-MM-dd HH:mm:SS');
          DateTime eventDateTime = serverDateFormat.parse(eventTimeString);
          String formattedEventTime =
              DateFormat('yy/MM/dd h:mm a').format(eventDateTime);
          String startAtPrefix = localizations.eventStartsAtPrefix;
          String startsAtString = '$startAtPrefix $formattedEventTime';
          String eventLocationDescription;
          Map<String, dynamic> eventLocation = event['location'];
          if (eventLocation != null) {
            eventLocationDescription = eventLocation['description'];
          }
          EventPreview eventView = EventPreview(
              eventLocation: eventLocationDescription,
              eventDescription: startsAtString,
              eventTime: eventName,
              onTap: () => _launchIndoorMapsForEvent(event));
          return eventView;
        },
      );
    } else {
      return Text(
        localizations.noEventsMessage,
        textAlign: TextAlign.center,
      );
    }
  }

  void _launchIndoorMapsForEvent(Map<String, dynamic> event) async {
    String eventString = json.encode(event);
    try {
      await AppConstants.platformChannel
          .invokeMethod('indoorMaps', {"event": eventString});
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
