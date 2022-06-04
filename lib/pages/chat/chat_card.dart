
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universales_proyecto/bloc/canal/canal_bloc.dart';
import 'package:universales_proyecto/model/chanel_model.dart';
import 'package:universales_proyecto/pages/chat/messagges/message_screen.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';

import 'dart:math' as math;

class ChatCard extends StatelessWidget {

  VoidCallback press;
  String idCanal;
  String uidUser;

  ChatCard({
    Key? key,
    required this.press,
    required this.idCanal, 
    required this.uidUser,
  }) : super(key: key);


  late CanalBloc canalBloc;
  DateFormat dateFormat = DateFormat.yMd().add_jm(); 
  @override
  Widget build(BuildContext context) {

    canalBloc = BlocProvider.of<CanalBloc>(context);

    return StreamBuilder(
      stream: canalBloc.streamCanalUser(idCanal).onValue,
      builder:(context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.active:
          case ConnectionState.done:
            if(!snapshot.hasData || snapshot.hasError){
              return const SplashScree();  // o CircularProgresIndicator
            }else{
              if(snapshot.data.snapshot.value==null) return Center();
              
              Map<dynamic, dynamic> data = snapshot.data.snapshot.value;
              final dataJson = json.decode(json.encode(data));
              final infoCanal = ChanelModel.fromJson(dataJson);

              return InkWell(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context){
                        return BlocProvider.value(
                          value: canalBloc,
                          child: MessageScreen(
                            uidUser: uidUser,
                            idCanal: idCanal,
                            listaUser:infoCanal.usuarios,
                            nombreCanal: infoCanal.nombre,
                            descripcion: infoCanal.descripcion,
                            canalBloc: canalBloc,
                          ),
                        );
                      }
                    )
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding*0.75),
                  child: Row(
                  children:[
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Color((infoCanal.fechaCreacion * 5 * 0xFFFFFF).toInt()),
                      child: Center(
                        child: Text(
                          infoCanal.nombre[0],
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(infoCanal.nombre),
                            Text(dateFormat.format(DateTime.fromMillisecondsSinceEpoch(infoCanal.fechaCreacion)))
                          ],
                        ),
                      ),
                    )
                  ]
                  ),
                ),
              );
            }

          default:
            return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}