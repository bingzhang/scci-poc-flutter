/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/model/User.dart';

class AppUtils {
  static const String _userKey = "user";

  static String generateUserUuid() {
    var uuid = new Uuid();
    String generatedUuid = uuid.v4();
    return generatedUuid;
  }

  static Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userToString = prefs.getString(_userKey);
    User user;
    if (!isStringEmpty(userToString)) {
      user = User.fromJson(json.decode(userToString));
    }
    return user;
  }

  static Future<void> saveUser(User user) async {
    if (user == null) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToString = json.encode(user);
    await prefs.setString(_userKey, userToString);
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
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

  static FontWeight fontWeightFromString(String key){
    switch (key){
      case "bold"  : return FontWeight.bold;
      case "thin"  : return FontWeight.w100;
      case "light" : return FontWeight.w300;
      default      : return FontWeight.normal;
    }
  }
  static FontStyle fontStyleFromString(String key){
    switch (key){
      case "italic" : return FontStyle.italic;
      default       : return FontStyle.normal;
    }
  }
}

class AppConstants {
  static const String serverHost = "https://profile.inabyte.com";
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
  static const Color buttonDefaultBackColor =
      Color.fromARGB(255, 20, 28, 45);
  static const appBrandColor = Color.fromARGB(255, 28, 38, 58);
  static const TextStyle buttonDefaultTextStyle =
      TextStyle(color: Colors.white);

  static const TextStyle roundedTextButtonStyle =
  TextStyle(color: Colors.white,fontSize:32);
  static const Border roundedButtonBorder = Border(
      top: _roundedButtonBorderSide,
      right: _roundedButtonBorderSide,
      bottom: _roundedButtonBorderSide,
      left: _roundedButtonBorderSide);
  static const roundedButtonBoxShape = BoxShape.rectangle;
  static const roundedButtonBorderRadius =
      BorderRadius.all(Radius.circular(5.0));
  static const roundedButtonPadding =
      Padding(padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 30.0));
  static const double buttonsSpacing = 12;
  static const double buttonsPaddingW = 6;
  static const double topSpacing = 32;
  static const double buttonsAspectRatio = 0.375;

  static const BorderSide _roundedButtonBorderSide = BorderSide(
      color: buttonDefaultBackColor, width: 2.0, style: BorderStyle.solid);

  static const Border emptyBorder = Border(
      top: _emptyBorderSide,
      right: _emptyBorderSide,
      bottom: _emptyBorderSide,
      left: _emptyBorderSide);

  static const BorderSide _emptyBorderSide = BorderSide(
      color: Colors.transparent, width: 0, style: BorderStyle.none);

}
