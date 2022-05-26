

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universales_proyecto/bloc/canal/canal_bloc.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/pages/chat/canal_info/user_card_channel_edit.dart';
import 'package:universales_proyecto/pages/chat/group/user_card.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/widget/splash_screen.dart';

class CanalInfo extends StatefulWidget {

  String uidLogueado;
  String idCanal;
  Map<String, dynamic> listUsuarios;
  String nombreCanal;
  String descripcion;

  CanalInfo({
    Key? key, 
    required this.uidLogueado, 
    required this.idCanal, 
    required this.listUsuarios, 
    required this.nombreCanal, 
    required this.descripcion
  }) : super(key: key);

  @override
  State<CanalInfo> createState() => _CanalInfoState();
}

class _CanalInfoState extends State<CanalInfo> {
  late CanalBloc bloc;

  List<UserChat> usuarios = [];

  List<UserChat> usuariosCanal = [];

  List<UserChat> usuariosNoCanal = [];

  @override
  Widget build(BuildContext context) {
    
    bloc = BlocProvider.of<CanalBloc>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(""),
        centerTitle: true,
      ),
      body: Container(
        color:Color.fromARGB(255, 231, 227, 227),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            buildEncabezado(),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding/2)
            ),
            buildConfiguracion(),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding/2)
            ),
            buildParticipantes(context),
          ],
        ),
      ),
    );
  }

  Widget buildParticipantes(BuildContext context){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal:kDefaultPadding),
      child: Column(
        children: [        
          FloatingActionButton(
            onPressed: (){
            _showdiaog(context);
            },
            child: Icon(Icons.people),
          ),
          Container(
            height: 400,
            child: FutureBuilder(
              future: bloc.listUser(),
              builder: (context,AsyncSnapshot snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if(!snapshot.hasData || snapshot.hasError){
                      return buildLista(usuariosCanal,false);
                    }else{                
                      final data = snapshot.data.value;
                      final dataJson = json.decode(json.encode(data));

                      dataJson.forEach((key, value) {
                              
                        Map<String,dynamic> data = json.decode(json.encode(value));                        
                        UserChat us = UserChat.fromJson(data);
                        us.uid = key;
                        
                        if(usuarios.where((element) => element.uid == key).isEmpty) {
                          usuarios.add(us);
                        }
                      });

                      widget.listUsuarios.forEach((key, value) {
                        if(usuarios.where((element) => element.uid==key).isNotEmpty){
                          usuariosCanal.add(usuarios.firstWhere((element) => element.uid==key));
                        }
                      });

                      usuarios.forEach((element) {
                        if(!usuariosCanal.contains(element)){
                          usuariosNoCanal.add(element);
                        }
                      });

                      return buildLista(usuariosCanal,false);
                    }
                  default:
                    return buildLista(usuariosCanal,false);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEncabezado(){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding/2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.nombreCanal,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 25
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: kDefaultPadding/2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Grupo . "+ widget.listUsuarios.length.toString() +" participantes",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[400]
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding,),
        ],
      ),
    );
  }

  Widget buildLista(List<UserChat> lista, bool agregar){
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return UserCardChannelEdit(
          usuario: lista[index],
          agregar: agregar,
          bloc: bloc,
          uidLogueado: widget.uidLogueado,
          idCanal: widget.idCanal,
          informarActualizacion: (){},
        );
      },
    );
  }

  Widget buildConfiguracion(){
    return  Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Icon(Icons.delete,color:Colors.grey[400]),
              ),
              Expanded(
                child: Text(
                  "Eliminar canal",
                  style: TextStyle(
                    fontWeight: FontWeight.w300
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void informarActualizacion(){
    setState(() {
      
    });
  }

  void _showdiaog(BuildContext context){
    showDialog(
      context: context, 
      builder: (context){
        return SimpleDialog(
          title: Text('Chosse people'),
          children: [
            Container(
              height: 300,
              width: 300,
              child: buildLista(usuariosNoCanal,true)
            )
          ],
        );
      });
  }
}