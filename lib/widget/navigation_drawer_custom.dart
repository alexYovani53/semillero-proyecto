

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/pages/editProfile/edit_profile.dart';
import 'package:universales_proyecto/pages/profile/profile.dart';
import 'package:universales_proyecto/pages/settings/page_setting.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/utils/config.dart';
class NavigationDrawerCustom extends StatelessWidget {
  
  NavigationDrawerCustom({ Key? key }) : super(key: key);

  late LanguajeProvider lang;
  late LocalizationsApp diccionary;
  late ThemeProvider theme;
  late UserBloc bloc;

  @override
  Widget build(BuildContext context) {

    lang = Provider.of<LanguajeProvider>(context,listen: false);
    diccionary = LocalizationsApp(lang.getLanguaje);
    theme =Provider.of<ThemeProvider>(context,listen: false );
    bloc = BlocProvider.of<UserBloc>(context,listen: false );


    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context)
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: theme.getTheme==ThemeMode.light? kContentColorLightTheme2:Color.fromARGB(255, 47, 47, 56),
      padding: EdgeInsets.only(
        top:24 + MediaQuery.of(context).padding.top,
        bottom:24
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: getImage(bloc.sesion?.photoURL??""),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(kDefaultPadding/2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    bloc.sesion?.name??"",
                    style:TextStyle(fontSize: 22, color: Colors.white)
                  ),
                ),
              ],
            ),
          ),          
          Text(
            bloc.sesion?.email??"",
            style:TextStyle(fontSize: 16, color: Colors.white)
          )
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.accessibility_rounded),
            title:  Text(diccionary.diccionario(Strings.navItem1)),
            onTap: (){
              
              Navigator.pop(context);
              bloc.add(UserEventPageProfile());
              // Navigator.pop(context);
              // Navigator.popUntil(context, (route) => route.isFirst);
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(
              //     builder: (ctx){
                    
              //       return BlocProvider.value(
              //         value: BlocProvider.of<UserBloc>(context),
              //         child: Profile(),
              //       );
              //     }
              //   )
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.message_sharp),
            title:  Text(diccionary.diccionario(Strings.navItem2)),
            onTap: (){
              
              Navigator.pop(context);
              bloc.add(UserEventPageChat());
              // Navigator.pop(context);
              // Navigator.popUntil(context, (route) => route.isFirst);
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(
              //     builder: (ctx){
              //       return BlocProvider.value(
              //         value: BlocProvider.of<UserBloc>(context),
              //         child: const EditProfile(),
              //       );
              //     }
              //   )
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_applications),
            title:  Text(diccionary.diccionario(Strings.navItem3)),
            onTap: (){
              Navigator.pop(context);
              bloc.add(UserEventPageSettings());
              // Navigator.pop(context);
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(
              //     builder: (ctx){
              //       return BlocProvider.value(
              //         value: BlocProvider.of<UserBloc>(context),
              //         child: const PageSetting(),
              //       );
              //     }
              //   )
              // );
            },
          ),
          const Divider(color: Colors.black54),
          IconButton(
            onPressed: (){
              Navigator.popUntil(context, (route) => route.isFirst);
              bloc.add(userEventLogOut());
            }, 
            icon: Icon(Icons.logout)
          ),
          const Divider(color: Colors.black54),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Pre-Proyecto',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                fontSize:20,
              )              
            ),
          ),          
          const SizedBox(
            height: 5,
          ),
          const Center(
            child: Text(
              'Version 1.0.1',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                fontSize:12,
              )              
            ),
          )
        ],
      )
    );
  }

  ImageProvider? getImage(photoUrl){
    if(photoUrl != ""){
      return NetworkImage(photoUrl);
    }else{
      return const AssetImage("assets/images/setting.png");
    }
  }
}
