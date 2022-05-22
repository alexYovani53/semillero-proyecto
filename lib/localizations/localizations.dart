
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/utils/app_string_en.dart';
import 'package:universales_proyecto/utils/app_string_es.dart';

class LocalizationsApp{

  final Locale locale;
  
  LocalizationsApp(this.locale);

  static LocalizationsApp of(BuildContext context){
    return Localizations.of<LocalizationsApp>(context,LocalizationsApp)!;
  }

  static final Map<String,Map<Strings,String>> _localizedValues = {
    'es':dictionary_es,
    'en':dictionary_en
  };

  String diccionario(Strings label) => _localizedValues[locale.languageCode]![label]??"";



}

class LocalizationsAppDelegate extends LocalizationsDelegate<LocalizationsApp> {

  const LocalizationsAppDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es','en'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationsApp> load(Locale locale) {
    return SynchronousFuture<LocalizationsApp>(LocalizationsApp(locale));
  }

  @override
  bool shouldReload(LocalizationsAppDelegate old) {
    return false;
  }
 

}
