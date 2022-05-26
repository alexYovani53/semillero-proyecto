import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universales_proyecto/bloc/canal/canal_bloc.dart';
import 'package:universales_proyecto/model/chanel_model.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';
import 'package:universales_proyecto/pages/chat/canal_info/canal_info.dart';
import 'package:universales_proyecto/pages/chat/messagges/message.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';

class MessageScreen extends StatefulWidget {
  
  String uidUser;
  String idCanal;
  String nombreCanal;
  String descripcion;
  CanalBloc canalBloc;
  Map<String, dynamic> listaUser;

  MessageScreen({
    Key? key,
    required this.uidUser,
    required this.idCanal,
    required this.canalBloc, 
    required this.nombreCanal,
    required this.descripcion, 
    required  this.listaUser
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  List<MesajeModel> mensajes = [];
  final controllerMensaje = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody2(context),
    );
  }

  Widget buildBody2(BuildContext context){
    return FutureBuilder(
      future: widget.canalBloc.recuperarMensajesChat(widget.idCanal),
      builder: (context,AsyncSnapshot snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done:
          case ConnectionState.active:

            if(!snapshot.hasData || snapshot.hasError){
              return SplashScree();
            }else{
              
              Map<dynamic, dynamic> data = snapshot.data.value;
              final dataJson = json.decode(json.encode(data));
              final infoCanal = MesajeModel.mensajeList(dataJson);

              for (var actual in infoCanal) {
                if(mensajes.where((almacenado) => almacenado.idMensaje== actual.idMensaje).isEmpty){
                  mensajes.add(actual);
                }
              }
              return Column(
                
                children: [
                  // Spacer(),
                  StreamBuilder<Object>(
                    stream: widget.canalBloc.streamMensajesOrdenados2(widget.idCanal),
                    builder: (context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState){
                        case ConnectionState.done:
                        case ConnectionState.active:
                          if(!snapshot.hasData || snapshot.hasError){
                            return SplashScree();
                          }else{
                            final data = snapshot.data.snapshot.value;
                            final dataJson = json.decode(json.encode(data));
                            final mensaje = MesajeModel.fromJson(dataJson);
                            mensaje.idMensaje = snapshot.data.snapshot.key;
                            if(mensajes.where((element) => element.idMensaje == mensaje.idMensaje).isEmpty){
                                 mensajes.add(mensaje);
                            }

                            mensajes.sort((a,b)=> b.fechaEnvio.compareTo(a.fechaEnvio));
                            return Expanded(
                                child: Container(
                                  color:Colors.lightGreen,
                                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                  child: ListView.builder(
                                    reverse: true,
                                    itemCount: mensajes.length,
                                    itemBuilder: (context,index) => Message(
                                      mensaje:mensajes[index],
                                      isSender:mensajes[index].usuario == widget.uidUser? true:false
                                    ),
                                  ),
                                ),
                              );         
                          }
                        default:
                          return CircularProgressIndicator();
                      }
                    }
                  ),    
                  buildInput(context),
                ],
              );
            }
            
            
          default:
            return CircularProgressIndicator();
        
        }
      },
    );
  }

  AppBar buildAppBar(BuildContext context){
    return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/chat.png"),
            ),
            const SizedBox(width: kDefaultPadding*0.75,),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(                    
                    builder: (ctx){                      
                      return BlocProvider.value(
                        value: widget.canalBloc,
                        child: CanalInfo(
                          uidLogueado:widget.uidUser,
                          idCanal:widget.idCanal,
                          listUsuarios:widget.listaUser,
                          nombreCanal:widget.nombreCanal,
                          descripcion:widget.descripcion                      
                        ),
                      );
                    }
                  )
                );
              },
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nombreCanal,
                    style: TextStyle(fontSize: 16)
                  ),
                  Text(
                    widget.descripcion,
                    style: TextStyle(fontSize: 12)
                  )
                ],
              ),
            )
          ]
        ),
      );
  }

  Widget buildInput(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2
      ),
      decoration: BoxDecoration(
        //color:Colors.blue
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0,4),
            blurRadius: 32,
            color: Color(0xff087949).withOpacity(0.08)
          )
        ]
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75
                ),
                decoration: BoxDecoration(
                  color:Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_outlined),
                    SizedBox(width: kDefaultPadding / 4,),
                    Expanded(
                      child: TextField(
                        controller: controllerMensaje,
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: kDefaultPadding * 2.5,
              padding: EdgeInsets.only(left: 5),
              child: FloatingActionButton(
                onPressed: (){
                  if(controllerMensaje.text.isEmpty) return;
                  widget.canalBloc.add(
                    CanalEnviarMensajeEvent(
                      idCanal: widget.idCanal,
                      texto: controllerMensaje.text, 
                      type: "texto", 
                      usuario: widget.uidUser
                    )
                  );

                  controllerMensaje.clear();
                },
                child: Icon(Icons.send_rounded)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
