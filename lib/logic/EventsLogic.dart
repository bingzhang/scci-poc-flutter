/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/utility/Utils.dart';

class EventsLogic {
  static final EventsLogic _logic = new EventsLogic._internal();
  List<dynamic> _eventsJson;

  factory EventsLogic() {
    return _logic;
  }

  EventsLogic._internal();

  Future<void> loadAllEvents() async {
    _eventsJson = await ServerRequest.loadAllEvents();
  }

  List<dynamic> getAllEvents() {
    return _eventsJson;
  }

  Future<List<dynamic>> loadEventsByRole(Role role) async {
    if (role == null || role == Role.unknown) {
      return null;
    }
    String roleToString = AppUtils.userRoleToString(role);
    List<dynamic> events = await ServerRequest.loadEventsByRole(roleToString);
    return events;
  }
}