
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/bloc/user_chat/user_chat_bloc.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/pages/chat/group/confirm_group.dart';
import 'package:universales_proyecto/pages/chat/group/userAvatar.dart';
import 'package:universales_proyecto/pages/chat/group/user_card.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/widget/custo_page_router.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';

class GroupPage extends StatefulWidget {
  
  GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {


  List<UserChat> group = [];
  List<UserChat> usuariosData = [];

  

  late ThemeProvider theme;
  late String uid;

  @override
  Widget build(BuildContext context) {

    theme = Provider.of<ThemeProvider>(context);
    final bloc = BlocProvider.of<UserBloc>(context);
    uid = bloc.sesion!.uid;

    return BlocProvider(
      create: (context) => UserChatBloc(),
      child: BlocListener<UserChatBloc,UserChatState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case  UserChatInitState:
              break;
            default:
          }
        },
        child: BlocBuilder<UserChatBloc,UserChatState>(
          builder: (context, state) {
            return StreamBuilder(
              stream: BlocProvider.of<UserChatBloc>(context).usuarios.onValue,
              builder: (context, AsyncSnapshot  snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if(!snapshot.hasData || snapshot.hasError ){
                      return const SplashScree();
                    }else{
                      Map<dynamic, dynamic> usuarios = snapshot.data.snapshot.value;
                      usuarios.forEach((key, value) {
                        Map<String,dynamic> data = json.decode(json.encode(value));                        
                        UserChat us = UserChat.fromJson(data);
                        us.uid = key;
                        
                        if(key == uid){
                          if(group.where((element) => element.uid == key).isEmpty) group.add(us);
                          else group.where((element) => element.uid == key).first.estado = us.estado;
                        }else{
                          if( usuariosData.where((element) => element.uid == key).isEmpty) usuariosData.add(us);
                          else usuariosData.where((element) => element.uid == key).first.estado = us.estado;
                        }

                      });

                      return buildBody(context);
                    }
                  default:
                    return Center(
                      child:CircularProgressIndicator()
                    );
                }
              },
            );            
          },
        ),
      ),
    );
  }

  Widget buildBody (BuildContext context){
    return Column(
      children: [
        if(group.isNotEmpty)...[
          Container(
            height: 80,
            color: theme.getTheme == ThemeMode.light?Colors.white:Color.fromARGB(57, 255, 255, 255),
            child: ListView.builder(
              
              scrollDirection: Axis.horizontal,
              itemCount: group.length,
              itemBuilder: (context,index){
                return  UserAvatar(showButton: true,usuario:group[index],onTap:(){
                  setState(() {
                    usuariosData.where((element) =>element.uid== group[index].uid ).first.selected = false;
                    
                    group.remove(group[index]);
                  });
                });
              },
            ),
          )
        ],
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                itemCount: usuariosData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      if(!usuariosData[index].selected){
                        setState(() {
                          usuariosData[index].selected = true;
                          group.add(usuariosData[index]);
                        });
                      }else{                                      
                        setState(() {
                          usuariosData[index].selected = false;
                          group.remove(usuariosData[index]);
                        });
                      }
                    },
                    child: UserCard(usuario: usuariosData[index]),
                  );
                },
              ),
              Positioned(
                bottom: kDefaultPadding,
                right:kDefaultPadding,
                child: FloatingActionButton(
                  onPressed: (){
                    if(group.isEmpty) {
                      showFlushBar("Canal", "Debe agregar un usuario", context);
                      return;
                    }
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        child: BlocProvider.value(
                          value: BlocProvider.of<UserBloc>(context),
                          child: ConfirmGroup(seleccionados: group),
                        )
                      )
                    ).then((value){
                      if(value!=null && value==true){
                        group.removeWhere((element) => element.uid!= uid);
                        usuariosData.forEach((element) {
                          element.selected = false;
                        });
                      }
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios,size: 20),
                )
              )
            ],
          ),
        )
      ],
    );
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