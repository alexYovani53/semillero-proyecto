import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/init_page.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/widget/navigation_drawer_custom.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';


void main(){
  
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    ()=>runApp(const MyApp()),
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);    
    }
  );
}

class MyApp extends StatefulWidget {

  const MyApp({ Key? key }) : super(key: key);
  static bool connected = false;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Future<void> _firebase;
  
  ThemeProvider themeProvider = ThemeProvider();
  LanguajeProvider languajeProvider = LanguajeProvider();

  
  Future<void> initiliazeFireBase() async{
    await Firebase.initializeApp();
    await inicializarConfs();
    await initiliazeCrashlytics();
    await initializeRealTime();
    print("LLego acá, inicio firebase?");
  }


  Future<void> inicializarConfs() async{
    print("ingreso a iniciar configuraciones");
    themeProvider.setTheme = await ThemeProvider().getInitTheme();
    languajeProvider.setLanguaje = await LanguajeProvider().getLocaleInit();
  }

  Future<void> initializeRealTime() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    // DatabaseReference ref = database.ref("mode");
    // ref.onValue.listen((DatabaseEvent event) {            
    //   final data = event.snapshot.child("theme").value as String;
    //   print(data);
    // });
  }


  Future<void> initiliazeCrashlytics() async{
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = (FlutterErrorDetails errorDetails) async{
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

  }

  @override
  void initState(){

    _firebase = initiliazeFireBase();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initiliazeFireBase(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return InitPage();
        }else{
          return MaterialApp(
            home: SplashScree(),
          );
        }
      },
    );
  }
}



