/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static const String _USER_UUID_KEY = "user_uuid";

  static void generateUserUuidIfNeeded() async {
    String userUuid = await getUserUuid();
    if (userUuid == null) {
      var uuid = new Uuid();
      final String generatedUuid = uuid.v4();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_USER_UUID_KEY, generatedUuid);
    }
  }

  static Future<String> getUserUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userUuid = prefs.getString(_USER_UUID_KEY);
    return userUuid;
  }

  static bool isStringEmpty(String stringToCheck) {
    return (stringToCheck == null || stringToCheck.isEmpty);
  }
}

class AppConstants {
  static const String DEFAULT_SERVER_HOST = "https://profile.inabyte.com";
  static const String SERVER_PORT = "8082";
}

class UiUtils {
  static DecorationImage buildDecorationImage(String imagePath) {
    if (AppUtils.isStringEmpty(imagePath)) {
      return null;
    }
    return DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill);
  }
}

class UiConstants {
  static const Color BUTTON_DEFAULT_BACK_COLOR =
      Color.fromARGB(255, 20, 28, 45);
  static const TextStyle BUTTON_DEFAULT_TEXT_STYLE =
      TextStyle(color: Colors.white);
  static const Border ROUNDED_BUTTON_BORDER = Border(
      top: _roundedButtonBorderSide,
      right: _roundedButtonBorderSide,
      bottom: _roundedButtonBorderSide,
      left: _roundedButtonBorderSide);
  static const ROUNDED_BUTTON_BOX_SHAPE = BoxShape.rectangle;
  static const ROUNDED_BUTTON_BORDER_RADIUS =
      BorderRadius.all(Radius.circular(5.0));
  static const ROUNDED_BUTTON_PADDING =
      Padding(padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 30.0));
  static const double HOME_BUTTONS_SPACING = 12;
  static const double HOME_BUTTONS_PADDING_W = 6;
  static const double HOME_TOP_SPACING = 32;
  static const double HOME_BUTTONS_ASPECT_RATIO = 0.40;

  static const BorderSide _roundedButtonBorderSide = BorderSide(
      color: BUTTON_DEFAULT_BACK_COLOR, width: 2.0, style: BorderStyle.solid);
}
