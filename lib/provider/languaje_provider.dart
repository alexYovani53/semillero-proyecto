

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:universales_proyecto/utils/app_preferences.dart';

class LanguajeProvider with ChangeNotifier{
  static Locale? _locale;

  Future<Locale> getLocaleInit() async {
    final String? savedCodeLanguaje = await AppPreferences.shared.getString(AppPreferences.APP_LANGUAJE);
    if(savedCodeLanguaje != null){
      _locale = Locale(savedCodeLanguaje);
      return Locale(savedCodeLanguaje);
    }else{
      _locale = Locale(Platform.localeName.substring(0,2));
      return _locale!;
    }
  }

  
  
  Locale get getLanguaje {
    if(_locale == null){
      getLocaleInit();      
    }
    return _locale!;
  }

  set setLanguaje (Locale newLang){
    _locale = newLang;
    AppPreferences.shared.setString(AppPreferences.APP_LANGUAJE,newLang.languageCode);
    notifyListeners();
  }

}
