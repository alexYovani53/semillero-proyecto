

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/canal/canal_bloc.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/provider/message_provider.dart';
import 'package:universales_proyecto/utils/config.dart';

class Message extends StatefulWidget {

  bool isSender;
  MesajeModel mensaje;
  Message({
    Key? key,
    required this.isSender, 
    required this.mensaje
  }) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {

  bool mostrarHora = false;
  DateFormat dateFormat = DateFormat.yMd().add_jm(); 
  bool editar =false;

  final controller = TextEditingController();
  
  late MessageProvider msProvider;
  late CanalBloc bloc;
  UserChat user =UserChat(uid: "", change: false, correo: "", estado: false, nombre: "", urlImage: "", canales: {});

  @override
  Widget build(BuildContext context) {
    
    msProvider = Provider.of<MessageProvider>(context,listen: true);
    bloc = BlocProvider.of<CanalBloc>(context);

    return FutureBuilder(
      future:bloc.infoUser(widget.mensaje.usuario),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            
            if(!snapshot.hasData || snapshot.hasError){
              return body();
            }else{
              final jsonData = json.decode(json.encode(snapshot.data.value));
              final userFinal = UserChat.fromJson(jsonData);
              user = userFinal;
              return body();
            }
          default:
            return body();
        }
      },
    );

    
  }

  Widget body(){
    return Container(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
          if(widget.mensaje.type!="notification")... [
            Row(
              mainAxisAlignment: 
                widget.isSender? MainAxisAlignment.end: MainAxisAlignment.start,
                children: [
                  if(!widget.isSender)...[
                    CircleAvatar(
                          radius:12,
                          backgroundImage: user.urlImage!=""?NetworkImage(user.urlImage):  AssetImage("assets/images/icono.png") as ImageProvider,
                    ),
                    SizedBox(width: kDefaultPadding/2,)
                  ],
                  Flexible(
                    child: textMessage(context)
                  ),          
                ],
            ),
          ]else...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: textMessageNotification(context)
                  ),          
                ],
            ),
          ],


          if(mostrarHora)...[
            Row(
              mainAxisAlignment: widget.isSender? MainAxisAlignment.end:MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.mensaje.fechaEnvio)),
                    style: const TextStyle(
                      fontSize: 10
                    ),
                  )
                ),
              ],
            )
          ]  
        ],
      ),
    );
  }

  Widget textMessage(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          mostrarHora=!mostrarHora;
        });
      },
      onDoubleTap: (){
        controller.text=widget.mensaje.texto;
        msProvider.updateMesage(widget.mensaje);
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 270),
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding/2),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(widget.isSender ? 1: 0.1),
          borderRadius: BorderRadius.circular(30)
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(!widget.isSender)...[
              Text(
                user.nombre,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff16B58B)
                ),
              ),
            ],
            Text(
                widget.mensaje.texto,
                style: TextStyle(
                  color: widget.isSender 
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1!.color
                ),
              ),
            if(widget.mensaje.fechaEdicion>0)...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                     dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.mensaje.fechaEdicion)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10
                    ),
                  ),
                ],
              )
            ]
          ],
        )
      ),
    );
    
  }
  
  Widget textMessageNotification(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          mostrarHora=!mostrarHora;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding/2),
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: BorderRadius.circular(30)
        ),
        child: Text(
          widget.mensaje.texto,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10
          ),
        ),
      ),
    );
  }
}