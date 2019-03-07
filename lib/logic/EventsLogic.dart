/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:profile_demo/http/ServerRequest.dart';

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
}