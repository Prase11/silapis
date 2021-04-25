import 'package:shared_preferences/shared_preferences.dart';

class UtilPreferences {
  static SharedPreferences preferences;

  static Future<bool> init() async {
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  static Future<bool> clear() {
    return preferences.clear();
  }

  static bool containsKey(String key) {
    return preferences.containsKey(key);
  }

  static dynamic get(String key) {
    return preferences.get(key);
  }

  static bool getBool(String key) {
    return preferences.getBool(key);
  }

  static double getDouble(String key) {
    return preferences.getDouble(key);
  }

  static int getInt(String key) {
    return preferences.getInt(key);
  }

  static Set<String> getKeys() {
    return preferences.getKeys();
  }

  static String getString(String key) {
    return preferences.getString(key);
  }

  static List<String> getStringList(String key) {
    return preferences.getStringList(key);
  }

  static Future<void> reload() {
    return preferences.reload();
  }

  static Future<bool> remove(String key) {
    return preferences.remove(key);
  }

  static Future<bool> setBool(String key, bool value) {
    return preferences.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) {
    return preferences.setDouble(key, value);
  }

  static Future<bool> setInt(String key, int value) {
    return preferences.setInt(key, value);
  }

  static Future<bool> setString(String key, String value) {
    return preferences.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return preferences.setStringList(key, value);
  }

  /*
   * Simpan access dan refresh token ke cache 
   */
  static void setToken({String accessToken, String refreshToken}) {
    if (accessToken != null) {
      preferences.setString('accessToken', accessToken);
    }

    if (refreshToken != null) {
      preferences.setString('refreshToken', refreshToken);
    }
  }

  ///Singleton factory
  static final UtilPreferences _instance = UtilPreferences._internal();

  factory UtilPreferences() {
    return _instance;
  }

  UtilPreferences._internal();
}
