/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/logic/EventsLogic.dart';
import 'dart:convert';

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
    String eventsString = EventsLogic().getAllEvents();

    return Scaffold(
      appBar: AppBar(
        title: Text(panelTitle),
        centerTitle: true,
      ),
      body: Text(eventsString),
    );
  }
}