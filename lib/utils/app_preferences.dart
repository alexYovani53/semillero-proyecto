
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  AppPreferences._privateConstructor();
  static final AppPreferences shared = AppPreferences._privateConstructor();

  static const APP_LANGUAJE = "LANGUAJE";
  static const APP_THEME = "THEME";
  static const APP_THEME_DEVICE = "THEME_DEVICE";
  static const APP_LANG_DEVICE = "LANG_DEVICE";
  static const APP_REMEMBER_ME = "REMEMBER_ME";
  static const APP_PASSWORD = "PASSWORD";
  static const APP_EMAIL = "EMAIL";

  setString(String key, String value) async{
    SharedPreferences objeto = await SharedPreferences.getInstance();
    objeto.setString(key, value);
  }

  setBool(String key, bool value) async{
    SharedPreferences objeto = await SharedPreferences.getInstance();
    objeto.setBool(key, value);
  }
  Future<bool> contains(String key) async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
  
}