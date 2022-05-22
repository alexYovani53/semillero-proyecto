
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  AppPreferences._privateConstructor();
  static final AppPreferences shared = AppPreferences._privateConstructor();

  static const APP_LANGUAJE = "LANGUAJE";
  static const APP_THEME = "THEME";
  static const APP_THEME_DEVICE = "THEME_DEVICE";
  static const APP_LANG_DEVICE = "LANG_DEVICE";

  setString(String key, String value) async{
    SharedPreferences objeto = await SharedPreferences.getInstance();
    objeto.setString(key, value);
  }

  setBool(String key, bool value) async{
    SharedPreferences objeto = await SharedPreferences.getInstance();
    objeto.setBool(key, value);
  }

  Future<String?> getString(String key) async {
    SharedPreferences objeto = await SharedPreferences.getInstance();
    return objeto.getString(key);
  }

  Future<bool?> getBool(String key) async {
    SharedPreferences objeto = await SharedPreferences.getInstance();
    return objeto.getBool(key);
  }
}