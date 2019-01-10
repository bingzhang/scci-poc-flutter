import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:profile_demo/model/User.dart';

class ServerRequest {

  Future<User> fetchUser() async {
    final response = await http.get(
        'https://localhost:8082/profile/87876786'); //TODO: DD - read from config

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Person');
    }
  }
}
