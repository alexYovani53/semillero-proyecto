import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/app_preferences.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/widget/navigation_drawer_custom.dart';

class PageSetting extends StatefulWidget {
  const PageSetting({ Key? key }) : super(key: key);

  @override
  State<PageSetting> createState() => _PageSettingState();
}

class _PageSettingState extends State<PageSetting> {

  late LocalizationsApp diccionary;
  final TextEditingController _langController = TextEditingController();

  bool usingThemeDevice = false;
  bool usingLangDevice = false;

  late List<String> items = ["English","Español"];
  String? selectedItem ;
  String? selectedTheme ;
  bool estado = false;
  

  void getDeviceConfigurations() async {
    bool datoTheme = await AppPreferences.shared.getBool(AppPreferences.APP_THEME_DEVICE)??false;
    bool datoLang = await AppPreferences.shared.getBool(AppPreferences.APP_LANG_DEVICE)??false;
    setState(() {      
      usingThemeDevice = datoTheme;
      usingLangDevice = datoLang;
    });
  }

  @override
  Widget build(BuildContext context) {

    getDeviceConfigurations();

    final LanguajeProvider lang = Provider.of<LanguajeProvider>(context,listen: false);
    final LocalizationsApp diccionary = LocalizationsApp(lang.getLanguaje);
    selectedItem = lang.getLanguaje.languageCode == "es"? "Español":"English";


    final ThemeProvider theme =Provider.of<ThemeProvider>(context);
    selectedTheme = theme.getTheme == ThemeMode.light? diccionary.diccionario(Strings.settingLight): diccionary.diccionario(Strings.settingDark);

    return Scaffold(
      backgroundColor: theme.getTheme == ThemeMode.light? Color(0XFF7A9BEE): Color.fromARGB(255, 47, 60, 92),
      drawer: NavigationDrawerCustom(),
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: (){
        //     Navigator.of(context).pop();
        //   },
        //   icon: Icon(Icons.arrow_back_ios),
        //   color: Colors.white
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          diccionary.diccionario(Strings.settingName),
          style: TextStyle(
            fontSize: 18.0,
            color:Colors.white
          ),
        ),
        centerTitle: true,
        actions:<Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
        ]
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(0, 202, 0, 0)
              ),
              Positioned(
                top:75.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45)
                    ),
                    color:theme.getTheme == ThemeMode.light? Colors.white: Colors.grey
                  ),
                ),
                height: MediaQuery.of(context).size.height - 100.0,
                width: MediaQuery.of(context).size.width
              ),
              Positioned (
                top:30.0,
                left: (MediaQuery.of(context).size.width /2)-100.0,
                child: Hero(
                  tag: "Saludo", 
                  child: Container(
                    decoration:const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/setting.png"),
                        fit: BoxFit.cover
                      )
                    ),
                    height: 200.0,
                    width: 200.0,
                  )
                )
              ),
              Positioned(
                top:250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom:5.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
                          color: Colors.black
                        ),
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Text(
                                diccionary.diccionario(Strings.settingTheme),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  diccionary.diccionario(Strings.settingDevice),
                                  style: TextStyle(
                                    color: theme.getTheme == ThemeMode.light? Colors.black: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold
                                  )
                                ),                                
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale:1,
                                  child: Switch.adaptive(
                                    value: usingThemeDevice, 
                                    onChanged: (value)=>setState(()=>{
                                      usingThemeDevice=value,
                                      AppPreferences.shared.setBool(AppPreferences.APP_THEME_DEVICE, value)
                                    }))
                                ),
                              ],
                            )
                              ],
                        ),
                        Container(height: 25.0, color: Colors.grey, width: 1.0),
                        Container(
                          width: 180.0,
                          height: 40.0,                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              color: theme.getTheme == ThemeMode.light? Color.fromARGB(255, 194, 181, 62): Color.fromARGB(255, 73, 73, 73)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(                                
                                key: const Key("Light"),
                                onTap: () async {
                                  if(usingThemeDevice) return;
                                  await changeTheme("Light", context);
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 50.0,
                                  decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17),topLeft: Radius.circular(17)),
                                      color: theme.getTheme == ThemeMode.light? Color.fromARGB(255, 235, 222, 104): Color.fromARGB(255, 73, 73, 73)
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.light_mode_rounded,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 80.0,
                                height: 40.0,
                                child: Center(
                                  child: Text(
                                    selectedTheme!,
                                    style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0),
                                  ) 
                                ),
                              ),
                              InkWell(
                                key: const Key("Dark"),
                                onTap: () async {
                                  if(usingThemeDevice) return;
                                  await changeTheme("Dark", context);
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 50.0,
                                  decoration:  BoxDecoration(
                                      borderRadius:  const BorderRadius.only( topRight: Radius.circular(17),bottomRight: Radius.circular(17)),
                                      color: theme.getTheme == ThemeMode.light? Color.fromARGB(255, 194, 181, 62): Color.fromARGB(255, 100, 93, 93)
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.dark_mode_rounded,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 35.0),
                    Padding(
                      padding: EdgeInsets.only(bottom:5.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0)),
                          color: Colors.black
                        ),
                        height: 50.0,
                        child: Center(
                          child: Text(
                            diccionary.diccionario(Strings.settingLanguaje),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  diccionary.diccionario(Strings.settingDevice),
                                  style: TextStyle(
                                    color: theme.getTheme == ThemeMode.light? Colors.black: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold
                                  )
                                ),                                
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale:1,
                                  child: Switch.adaptive(
                                    value: usingLangDevice, 
                                    onChanged: (value)=>setState(()=>{
                                      usingLangDevice=value,
                                      AppPreferences.shared.setBool(AppPreferences.APP_LANG_DEVICE, value)
                                    }))
                                ),
                              ],
                            )
                              ],
                        ),
                        SizedBox(
                          width: 240.0,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            dropdownColor: Colors.blueAccent,
                            
                            value: selectedItem,
                            items: items
                              .map((item)=> DropdownMenuItem<String>(
                                value:item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,

                                )  
                              )).toList(),
                            onChanged:(item) async {
                              if(usingLangDevice) return;
                              setState(()=> {
                                selectedItem = item
                              });

                              await changeLang(item!);
                            },
                            icon: const Icon(Icons.language_rounded),
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black
                            ),
                            
                          ),
                        )
                      ],
                    ),
                    
                    SizedBox(height: 35.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        Text(
                          selectedItem??"",
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0
                          )
                        ),
                        Container(height: 25.0, color: Colors.grey, width: 1.0),
                        // SizedBox(
                        //   width: 150.0,
                        //   child: DropDownCustom(
                        //     textEditingController: _langController,
                        //     setting: changeLang,
                        //   ),
                        // )
                      ],
                    ),


                  ],
                )
              ),
              

            ],
          )
        
        ],
      ),
    );
  }

  Future<void> changeTheme(String themeString, BuildContext context) async {

    await ThemeProvider().getInitTheme();
    ThemeMode temaActual;
    switch (themeString) {
      case "Claro":
      case "Light":
        temaActual = ThemeMode.light;
        break;
      case "Dark":
      case "Obscuro":
        temaActual = ThemeMode.dark;        
        break;
      default:
        temaActual = ThemeMode.light;
        break;
    }

    final themeChange = Provider.of<ThemeProvider>(context,listen:false);
    themeChange.setTheme = temaActual;
  }

  Future<void> changeLang(String langstring ) async {
    await LanguajeProvider().getLocaleInit();
    Locale locale;
    switch (langstring) {
      case "English":
      case "Inglés":
      case "en":
        locale = const Locale('en'); 
        break;
        
      case "Spanish":        
      case "Español":
      case "es":
        locale = const Locale('es'); 
        break;

      default:
        locale = const Locale('es'); 
    }
    
    final LanguajeProvider lang = Provider.of<LanguajeProvider>(context,listen: false);
    lang.setLanguaje = locale;

    setState(()=> {
      estado = !estado
    });
  }





  List<DropdownMenuItem<String>> getItems( BuildContext){

    final LanguajeProvider lang = Provider.of<LanguajeProvider>(context,listen: false);
    final LocalizationsApp diccionary = LocalizationsApp(lang.getLanguaje);

    items = [diccionary.diccionario(Strings.settingEnglish),diccionary.diccionario(Strings.settingSpanish)];

    return items.map((item)=> DropdownMenuItem<String>(
      value:item,
      child: Text(
        item,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
      )  
    )).toList();
  }
  
  
}