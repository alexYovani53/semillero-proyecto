import 'dart:ffi';

import 'package:universales_proyecto/model/mesaje_model.dart';

class Administradores {
  String uid;
  
  Administradores({required this.uid});

}


class ChanelModel {
  String nombre;
  Map<String,dynamic> administradores;
  String creador;
  String descripcion;
  int fechaCreacion;
  List<MesajeModel> mensajes;
  Map<String,dynamic> usuarios;

  ChanelModel({
    required this.nombre,
    required this.administradores,
    required this.creador,
    required this.descripcion,
    required this.fechaCreacion,
    required this.mensajes,
    required this.usuarios
  });

  ChanelModel.fromJson(Map<String,dynamic> data)
  : nombre=data["nombre"],
    administradores=data["administradore"]??{},
    creador=data["creador"],
    descripcion=data["descripcion"],
    fechaCreacion=data["fecha_creacion"],
    //mensajes=MesajeModel.mensajeList(data["mensajes"]??{}),
    mensajes=MesajeModel.mensajeList({}),
    usuarios=data["usuarios"]??{};

  Map<String,dynamic> toJson()=>{
    'nombre':nombre,
    'administradores':administradores,
    'creador':creador,
    'descripcion':descripcion,
    'fecha_creacion':fechaCreacion,
    'mensajes':mensajes,
    'usuarios':usuarios
  };

}