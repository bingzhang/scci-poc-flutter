/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/widgets/EventPreview.dart';
import 'package:profile_demo/logic/EventsLogic.dart';
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
          String startsAtString = 'Starts at $formattedEventTime';
          String eventLocationDescription;
          Map<String, dynamic> eventLocation = event['location'];
          if (eventLocation != null) {
            eventLocationDescription = eventLocation['description'];
          }
          EventPreview eventView = EventPreview(
              eventLocation: eventLocationDescription,
              eventDescription: startsAtString,
              eventTime: eventName);
          return eventView;
        },
      );
    } else {
      return Text(
        'There are no events!',
        textAlign: TextAlign.center,
      );
    }
  }
}
