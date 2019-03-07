/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/utility/Utils.dart';

class EventsLogic {
  static final EventsLogic _logic = new EventsLogic._internal();

  factory EventsLogic() {
    return _logic;
  }

  EventsLogic._internal();

  Future<List<dynamic>> loadAllEvents() async {
    return await ServerRequest.loadAllEvents();
  }

  /// Events filter logic:
  ///
  /// 'Student' -> Student & Other
  ///
  /// 'Staff' -> Staff & Other
  ///
  /// 'Other' -> Other
  Future<List<dynamic>> getEventsBy(Role role) async {
    if (role == null || role == Role.unknown) {
      return null;
    }
    List<dynamic> allEvents = await loadAllEvents();
    if (allEvents == null) {
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
    for (var event in allEvents) {
      String eventRole = event['user_role'];
      if (rolesArr != null && rolesArr.contains(eventRole)) {
        filteredEvents.add(event);
      }
    }
    return filteredEvents;
  }
}
