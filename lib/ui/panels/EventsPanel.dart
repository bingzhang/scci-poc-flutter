/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/logic/EventsLogic.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/platform/Communicator.dart';
import 'package:profile_demo/ui/widgets/EventPreview.dart';
import 'package:intl/intl.dart';

class EventsPanel extends StatefulWidget {
  final String title;

  EventsPanel({Key key, this.title}) : super(key: key);

  @override
  _EventsPanelState createState() => _EventsPanelState(title);
}

class _EventsPanelState extends State<EventsPanel> {
  final _panelTitle;
  List<dynamic> _events;
  bool _loading = false;

  _EventsPanelState(this._panelTitle) : super();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_panelTitle),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
            child: Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: _buildListView())),
            inAsyncCall: _loading));
  }

  Widget _buildListView() {
    if (_loading) {
      return Container();
    }
    AppLocalizations localizations = AppLocalizations.of(context);
    int eventsCount = (_events != null) ? _events.length : 0;
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
          Map<String, dynamic> event = _events[index];
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
    Communicator.launchIndoorMapsForEvent(eventString);
  }

  void _loadEvents() async {
    setLoading(true);
    Role userRole = ProfileLogic().getUser()?.role;
    _events = await EventsLogic().getEventsBy(userRole);
    setLoading(false);
  }

  void setLoading(bool isLoading) {
    setState(() {
      _loading = isLoading;
    });
  }
}
