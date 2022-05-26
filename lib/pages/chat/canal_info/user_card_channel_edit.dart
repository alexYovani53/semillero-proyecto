
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universales_proyecto/bloc/canal/canal_bloc.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/utils/config.dart';

class UserCardChannelEdit extends StatelessWidget {
  
  UserChat usuario;
  bool agregar;
  String uidLogueado;
  String idCanal;
  CanalBloc bloc;
  Function(bool,UserChat) informarActualizacion;

  UserCardChannelEdit({
    Key? key,
    required this.usuario, 
    required this.agregar,
    required this.bloc,
    required this.uidLogueado,
    required this.idCanal,
    required this.informarActualizacion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(agregar);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: usuario.urlImage!=""?NetworkImage(usuario.urlImage): AssetImage("assets/images/usericono.png") as ImageProvider,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Text(usuario.correo)),
                    ],
                  ),
                  Text(usuario.nombre)
                ],
              ),
            ),
          ),
          
          agregar
            ?IconButton(
              onPressed: () async {
                bloc.add(CanalAgregarUsuarioEvent(
                  idCanal: idCanal,
                  uidLogueado: uidLogueado,
                  uidUsuario: usuario.uid,                  
                  nombreLogueado: "undefined"
                ));
                
                informarActualizacion(
                  true,
                  usuario
                );
              }, 
              icon: Icon(
                Icons.add_box,
                color: Colors.blue,
              )
            )
            :IconButton(
              onPressed: (){
                bloc.add(CanalEliminUsuarioEvent(
                  idCanal: idCanal,
                  uidLogueado: uidLogueado,
                  uidUsuario: usuario.uid,
                  nombreLogueado: "undefined"
                ));
                
                informarActualizacion(
                  false,
                  usuario);
              }, 
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )
            )
        ],
      ),
    );
  }
}