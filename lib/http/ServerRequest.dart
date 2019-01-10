import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:profile_demo/model/User.dart';

class ServerRequest {

  static Future<User> fetchUser(String userUuid) async {
    final response = await http.get(
        'http://10.51.8.198:8082/profile?uuid=$userUuid'); //TODO: configure server IP

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Person');
    }
  }
}
