
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/main.dart';
import 'package:universales_proyecto/pages/login/login_page1.dart';
import 'package:universales_proyecto/pages/login/register_page.dart';
import 'package:universales_proyecto/pages/profile/profile.dart';
import 'package:universales_proyecto/pages/settings/page_setting.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';



class InitPage extends StatefulWidget {


  InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  ThemeProvider themeProvider = ThemeProvider();
  LanguajeProvider languajeProvider = LanguajeProvider();
  late UserBloc bloc;

  @override 
  void initState(){    
    var window = WidgetsBinding.instance!.window;

    // This callback is called every time the brightness changes.
    window.onPlatformBrightnessChanged = () {
      var brightness = window.platformBrightness;
      ThemeMode nuevo = brightness == Brightness.light? ThemeMode.light:ThemeMode.dark;
      themeProvider.setTheme = nuevo;
    };

    bloc = UserBloc();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: languajeProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: Consumer2<LanguajeProvider,ThemeProvider>(
        builder: (context, LanguajeProvider lang, ThemeProvider theme, child) {
          return MaterialApp(
            locale: languajeProvider.getLanguaje,
            localizationsDelegates: const[
              LocalizationsAppDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es',''),
              Locale('en','')
            ],
            themeMode: theme.getTheme,
            title: 'Flutter pre-proyecto',
            debugShowCheckedModeBanner: false,
            home: initPage(context)

          );
        },
      ),
    );
  }

  Widget initPage(BuildContext context){
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context)=>bloc)],
      child: BlocListener<UserBloc,UserState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case UserInitState:    
              break;
            default:
              break;
          }
        },
        child: BlocBuilder<UserBloc,UserState>(
          builder: (context, state) {
            return StreamBuilder(
              stream: bloc.streamFirebase,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(!snapshot.hasData || snapshot.hasError ){
                  return PageView(
                    children: [
                      LoginPage1(),
                      RegisterPage()
                    ],
                  );
                }else{
                  bloc.add(UserEventCarcarData());
                  return Profile();
                }
              },
            );
          },
        ),
      )
    );  
  }
}