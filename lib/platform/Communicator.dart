/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/services.dart';

class Communicator {
  static const MethodChannel _platformChannel =
      const MethodChannel("com.uiuc.profile/native_call");

  static void launchFnM(String title) async {
    try {
      await _platformChannel.invokeMethod('foodAndMerch');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  static void launchIndoorMaps(String eventsString) async {
    try {
      await _platformChannel
          .invokeMethod('indoorMaps', {"events": eventsString});
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  static void launchIndoorMapsForEvent(String eventString) async {
    try {
      await _platformChannel.invokeMethod('indoorMaps', {"event": eventString});
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
