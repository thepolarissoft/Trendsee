
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  // static final String keyToken = 'token';
  // static final String keyUserType = 'user_type';
  static final String keyEmail = 'email';
  static final String keyUsername = 'username';
  static final String keyCurrentLocation = 'current_location';
  static final String isInternet = 'internet';
  static final String keyStandardUserProfileObject = 'standard_user_profile';
  static final String keyBusinessUserProfileObject = 'business_user_profile';
  static final String keyUserId = 'user_id';


  static SharedPreferences prefs;

  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs;
  }

  static setStringValue(String key, String value) {
    return prefs.setString(key, value) ?? null;
  }

  static String getStringValue(String key) {
    return prefs.getString(key) ?? null;
  }

  static setIntValue(String key, int value) {
    return prefs.setInt(key, value);
  }

  static int getIntValue(String key) {
    return prefs.getInt(key) ?? 0;
  }

  static setBoolValue(String key, bool value) {
    return prefs.setBool(key, value);
  }

  static bool getBoolValue(String key) {
    return prefs.getBool(key) ?? true;
  }

  static setObject(String key, String value) {
    return prefs.setString(key, value);
  }

  static getObject(String key) {
    return prefs.getString(key) ?? null;
  }

  static clearPrefs() async {
    await prefs.clear();
  }
}
