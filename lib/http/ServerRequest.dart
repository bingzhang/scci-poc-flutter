/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/utility/Utils.dart';

class ServerRequest {
  static Future<User> fetchUser(String userUuid) async {
    if (AppUtils.isStringEmpty(userUuid)) {
      return null;
    }
    String serverHost = _constructHostValue();
    http.Response response;
    try {
      response = await http.get('$serverHost/profile?uuid=$userUuid');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      print('User with uuid $userUuid not found');
      return null;
    } else {
      print('Server error');
      print(response.body);
      return null;
    }
  }

  static Future<bool> saveUser(User user) async {
    if (user == null) {
      return false;
    }
    String serverHost = _constructHostValue();
    String userJson = json.encode(user);
    http.Response response;
    try {
      response = await http.post('$serverHost/profile', body: userJson, encoding: Encoding.getByName("utf-8"));
    } catch (e) {
      print(e.toString());
      return false;
    }

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to save user');
      print(response.body);
      return false;
    }
  }

  static Future<bool> deleteUser(String userUuid) async {
    if (AppUtils.isStringEmpty(userUuid)) {
      return null;
    }
    String serverHost = _constructHostValue();
    http.Response response;
    try {
      response = await http.delete('$serverHost/profile?uuid=$userUuid');
    } catch (e) {
      print(e.toString());
      return false;
    }

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete user');
      print(response.body);
      return false;
    }
  }

  static Future<String> loadUiConfigWithLanguage(String lang) async {
    String serverHost = _constructHostValue();
    http.Response response;
    try {
      response = await http.get('$serverHost/ui/config?lang=$lang');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Failed to load ui config');
      print(response.body);
      return null;
    }
  }

  static Future<List<dynamic>> loadAllEvents() async {
    String serverHost = _constructHostValue();
    http.Response response;
    try {
      response = await http.get('$serverHost/events');
    } catch (e) {
      print(e.toString());
      return null;
    }

    if (response.statusCode == 200) {
      List<dynamic> eventsJson = json.decode(response.body);
      return eventsJson;
    } else {
      print('Failed to load all events');
      print(response.body);
      return null;
    }
  }

  static String _constructHostValue() {
    String host = AppConstants.serverHost;
    if (host.startsWith("http://") || host.startsWith("https://")) {
      return host;
    }
    return 'http://$host';
  }
}
