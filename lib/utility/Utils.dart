import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Utils {

  static const String USER_UUID_KEY = "user_uuid";
  static const String HOST_PREFS_KEY = "server_host";

  static void generateUserUuidIfNeeded() async {
    String userUuid = await getUserUuid();
    if (userUuid == null) {
      var uuid = new Uuid();
      final String generatedUuid = uuid.v4();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(USER_UUID_KEY, generatedUuid);
    }
  }

  static Future<String> getUserUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userUuid = prefs.getString(USER_UUID_KEY);
    return userUuid;
  }

  static void saveHostAddress(String hostAddress) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(HOST_PREFS_KEY, hostAddress);
  }

  static Future<String> getHostAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String hostAddress = prefs.getString(HOST_PREFS_KEY);
    return hostAddress;
  }
}

class Constants {
  static const String DEFAULT_SERVER_HOST = "http://10.51.8.198";
  static const String SERVER_PORT = "8082";
}
