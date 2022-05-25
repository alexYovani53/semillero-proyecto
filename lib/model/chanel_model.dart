import 'dart:ffi';

class ChanelModel {
  String nombre;
  Map<String,dynamic> administradore;
  String creador;
  String descripcion;
  int fechaCreacion;
  Map<String,dynamic> mensajes;
  Map<String,dynamic> usuarios;

  ChanelModel({
    required this.nombre,
    required this.administradore,
    required this.creador,
    required this.descripcion,
    required this.fechaCreacion,
    required this.mensajes,
    required this.usuarios
  });

  Map<String,dynamic> toJson()=>{
    'nombre':nombre,
    'administradores':administradore,
    'creador':creador,
    'descripcion':descripcion,
    'fecha creacion':fechaCreacion,
    'mensajes':mensajes,
    'usuarios':usuarios
  };

}