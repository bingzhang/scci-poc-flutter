/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:profile_demo/model/Role.dart';

class AppUtils {
  static const String _USER_UUID_KEY = "user_uuid";

  static Future<void> generateUserUuidIfNeeded() async {
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

  static double parseDoubleFrom(dynamic value) {
    if (value == null) {
      return 0.0;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }
    return 0.0;
  }

  static String userRoleToString(Role role) {
    if (role == null) {
      return userRoleToString(Role.unknown);
    }
    String roleToString = role.toString();
    const int subStringStartIndex =
        'Role.'.length; //remove enum class from toString method
    return roleToString.substring(subStringStartIndex);
  }

  static Role userRoleFromString(String roleString) {
    if (AppUtils.isStringEmpty(roleString)) {
      return Role.unknown;
    }
    return Role.values
        .firstWhere((role) => userRoleToString(role) == roleString);
  }
}

class AppConstants {
  static const String DEFAULT_SERVER_HOST = "http://profile.inabyte.com";
  static const String SERVER_PORT = "8082";
}

class UiUtils {
  static DecorationImage buildDecorationImage(String imageType, String imagePath) {
    if (AppUtils.isStringEmpty(imagePath)) {
      return null;
    }
    ImageProvider imageProvider;
    if (imageType == 'internal') {
      imageProvider = AssetImage(imagePath);
    } else if (imageType == 'external') {
      Image networkImage = Image.network(imagePath);
      if (networkImage != null) {
        imageProvider = networkImage.image;
      }
    }
    return (imageProvider != null) ? DecorationImage(image: imageProvider, fit: BoxFit.fill) : null;
  }
}

class UiConstants {
  static const Color BUTTON_DEFAULT_BACK_COLOR =
      Color.fromARGB(255, 20, 28, 45);
  static const APP_BRAND_COLOR = Color.fromARGB(255, 28, 38, 58);
  static const TextStyle BUTTON_DEFAULT_TEXT_STYLE =
      TextStyle(color: Colors.white);

  static const TextStyle ROUNDED_TEXT_BUTTON_STYLE =
  TextStyle(color: Colors.white,fontSize:32);
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
  static const double HOME_BUTTONS_ASPECT_RATIO = 0.375;

  static const BorderSide _roundedButtonBorderSide = BorderSide(
      color: BUTTON_DEFAULT_BACK_COLOR, width: 2.0, style: BorderStyle.solid);
}
