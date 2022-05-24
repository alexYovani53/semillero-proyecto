
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universales_proyecto/bloc/user_chat/user_chat_bloc.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/pages/chat/group/userAvatar.dart';
import 'package:universales_proyecto/pages/chat/group/user_card.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';

class GroupPage extends StatefulWidget {
  
  GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {


  List<UserChat> group = [];
  List<UserChat> usuariosData = [];

  @override
  Widget build(BuildContext context) {
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
                        if( usuariosData.where((element) => element.uid == key).isEmpty) usuariosData.add(us);
                      });

                      return buildBody();
                    }
                  default:
                    return CircularProgressIndicator();
                }
              },
            );            
          },
        ),
      ),
    );
  }

  Widget buildBody (){
    return Column(
      children: [
        Container(
          height: 80,
          color: Colors.white,
          child: ListView.builder(
            
            scrollDirection: Axis.horizontal,
            itemCount: group.length,
            itemBuilder: (context,index){
              return  UserAvatar(usuario:group[index],onTap:(){
                setState(() {
                  usuariosData.where((element) =>element.uid== group[index].uid ).first.selected = false;
                  
                  group.remove(group[index]);
                });
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
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
        )
      ],
    );
  }
}