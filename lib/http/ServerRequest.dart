import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/utility/Utils.dart';

class ServerRequest {
  static final host = Constants.SERVER_HOST;
  static final port = Constants.SERVER_PORT;

  static Future<User> fetchUser(String userUuid) async {
    final response = await http
        .get('$host:$port/profile?uuid=$userUuid'); //TODO: configure server IP

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

    String userJson = json.encode(user);
    final response = await http.post('$host:$port/profile',
        body: userJson, encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to save user');
      print(response.body);
      return false;
    }
  }

  static Future<bool> deleteUser(String userUuid) async {
    if (userUuid == null) {
      return false;
    }

    final response = await http.delete('$host:$port/profile?uuid=$userUuid');

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete user');
      print(response.body);
      return false;
    }
  }
}
