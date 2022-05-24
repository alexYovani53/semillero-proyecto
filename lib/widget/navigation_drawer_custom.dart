

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

    bloc.add(UserEventCarcarData());

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
      color: theme.getTheme==ThemeMode.light? Colors.blue.shade700:Colors.grey.shade500,
      padding: EdgeInsets.only(
        top:24 + MediaQuery.of(context).padding.top,
        bottom:24
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: getImage(bloc.sesion?.photoURL??""),
          ),
          SizedBox(height: 12),
          Text(
            bloc.sesion?.name??"",
            style:TextStyle(fontSize: 28, color: Colors.white)
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
            leading: const Icon(Icons.home_outlined),
            title: const Text('Profile'),
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
            leading: const Icon(Icons.home_outlined),
            title: const Text('Chat'),
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
            title: const Text('Configuraciones'),
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
          SizedBox(
            height: 5,
          ),
          const Center(
            child: Text(
              'Version 1.0.0',
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
