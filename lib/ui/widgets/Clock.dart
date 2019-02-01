/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String _dayString;
  String _timeString;

  @override
  void initState() {
    _initTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _dayString,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black87),
          ),
          Text(_timeString,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 26,
                  color: Colors.black87)),
        ]);
  }

  void _initTime() {
    final DateTime now = DateTime.now();
    _timeString = _formatTime(now);
    _dayString = _formatDate(now);
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);
    final String formattedDate = _formatDate(now);
    setState(() {
      _timeString = formattedTime;
      _dayString = formattedDate;
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime).toLowerCase();
  }

  String _formatDate(DateTime dateTime) {
    String dateFormat = DateFormat('EEEE, MMMM d').format(dateTime);
    String daySuffix = _formatDaySuffix(dateTime.day);
    return dateFormat + daySuffix;
  }

  String _formatDaySuffix(int day) {
    switch (day) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
