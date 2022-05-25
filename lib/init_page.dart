
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/pages/chat/chats_screen.dart';
import 'package:universales_proyecto/pages/login/login_page1.dart';
import 'package:universales_proyecto/pages/login/register_page.dart';
import 'package:universales_proyecto/pages/profile/profile.dart';
import 'package:universales_proyecto/pages/settings/page_setting.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/app_theme.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';



class InitPage extends StatefulWidget {

  Widget? hijo;

  InitPage({
    Key? key,
    this.hijo
  }) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> with TickerProviderStateMixin {

  ThemeProvider themeProvider = ThemeProvider();
  LanguajeProvider languajeProvider = LanguajeProvider();
  late UserBloc bloc;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override 
  void initState(){    
    var window = WidgetsBinding.instance.window;

    // This callback is called every time the brightness changes.
    window.onPlatformBrightnessChanged = () {
      var brightness = window.platformBrightness;
      ThemeMode nuevo = brightness == Brightness.light? ThemeMode.light:ThemeMode.dark;
      themeProvider.setTheme = nuevo;
    };
    bloc = UserBloc();
    
    ThemeProvider().getInitTheme();
    LanguajeProvider().getLocaleInit();

      _controller = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this,
      )..forward();
      _animation = Tween<Offset>(
        begin: const Offset(-0.5, 0.0),
        end: const Offset(0.5, 0.0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCubic,
      ));

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
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),
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
            case UserActualizacionState:
              break;
            
            case UserErrorState:
              showFlushBar(bloc.MensajeTitulo,bloc.MensajeError,context);
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

                  switch (state.runtimeType) {
                    case UserPageProfileState:   
                      return getAnimation(Profile(),1);
                      //return Profile();
                    case UserPageSettingsState:                          
                      return getAnimation(PageSetting(),1);
                      //return PageSetting();
                    case UserPageChatState:
                      return getAnimation(ChatsScreen(),1);
                      //return ChatsScreen();
                    default:
                      bloc.add(UserEventPageProfile());
                      return getAnimation(SplashScree(),1);
                  }

                }
              },
            );
          },
        ),
      )
    );  
  }

  Widget getAnimation(Widget page, int tipo){
    switch (tipo) {
      case 0:
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(0.5, 0.5), end: Offset(0, 0))
                  .animate(animation),
              child: child,
            );
          },
          child: page,
        );  
      default:
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 700),
          child: page,
        );   
    }
   
  }

   showFlushBar(String titulo, String texto,BuildContext context){
    Flushbar(
      title:  titulo,
      message:  texto,
      duration:  const Duration(seconds: 6),            
      margin:    const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      flushbarPosition: FlushbarPosition.TOP,
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);
  }
}