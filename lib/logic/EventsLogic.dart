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

  /// Events filter logic:
  ///
  /// 'Student' -> Student & Other
  ///
  /// 'Staff' -> Staff & Other
  ///
  /// 'Other' -> Other
  List<dynamic> filterEventsBy(Role role) {
    if (role == null || role == Role.unknown) {
      return null;
    }
    if (_eventsJson == null) {
      return null;
    }
    var rolesArr;
    switch (role) {
      case Role.student:
        rolesArr = [
          AppUtils.userRoleToString(Role.student),
          AppUtils.userRoleToString(Role.other)
        ];
        break;
      case Role.staff:
        rolesArr = [
          AppUtils.userRoleToString(Role.staff),
          AppUtils.userRoleToString(Role.other)
        ];
        break;
      case Role.other:
        rolesArr = [AppUtils.userRoleToString(Role.other)];
        break;
      default:
        break;
    }
    List<dynamic> filteredEvents = List();
    for (var event in _eventsJson) {
      String eventRole = event['user_role'];
      if (rolesArr != null && rolesArr.contains(eventRole)) {
        filteredEvents.add(event);
      }
    }
    return filteredEvents;
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
