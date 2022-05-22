
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:universales_proyecto/utils/app_preferences.dart';

class ThemeProvider with ChangeNotifier {

  static ThemeMode? _actual;
  

  Future<ThemeMode> getInitTheme() async{
    String? savedTheme = await AppPreferences.shared.getString(AppPreferences.APP_THEME);
    if(savedTheme != null){
      print("el valor es >>>>>>>>>>> $savedTheme");
      if (savedTheme == "claro" ) {
        _actual = ThemeMode.light;
      }else{
        _actual = ThemeMode.dark;
      }
    }else{        
      var bightness = SchedulerBinding.instance!.window.platformBrightness;
      _actual = (bightness == Brightness.light)?ThemeMode.light:ThemeMode.dark;
    }
    return _actual!;
  }

  ThemeMode get getTheme{
    if (_actual==null) {
      getInitTheme();
    }
    return _actual!;
  }

  set setTheme(ThemeMode modo){
    _actual = modo;
    String theme = modo==ThemeMode.light? "claro":"obscuro";
    AppPreferences.shared.setString(AppPreferences.APP_THEME, theme);
    notifyListeners();
  }

}