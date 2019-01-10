import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Utils {

  static final String PERSON_UUID_KEY = "person_uuid";

  static void generatePersonUuidIfNeeded() async {
    String personUuid = await getPersonUuid();
    if (personUuid == null) {
      var uuid = new Uuid();
      String personUuid = uuid.v4();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(PERSON_UUID_KEY, personUuid);
    }
  }

  static Future<String> getPersonUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String personUuid = prefs.getString(PERSON_UUID_KEY);
    return personUuid;
  }
}
