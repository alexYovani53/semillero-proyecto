import 'package:universales_proyecto/model/user_sesion.dart';

class CanalUser{
  String nombre;
  CanalUser({required this.nombre});
}

class UserChat{
  String uid;
  bool change;
  String correo;
  bool estado;
  String nombre;
  String urlImage;
  Map<String,dynamic> canales;
  bool selected = false;

  UserChat({
    required this.uid,
    required this.change,
    required this.correo,
    required this.estado,
    required this.nombre,
    required this.urlImage,
    required this.canales,
    selected = false
  });

  UserChat.fromJson(Map<String, dynamic> json)
      : uid = json['uid']??"",
        change = json['change'],
        correo = json['correo'],
        estado = json['estado'],
        nombre = json['nombre'],
        urlImage = json['urlImage'],        
        canales = json['Canales']??{};

  Map<String, dynamic> toJson() => {
    'change': change,
    'correo': correo,
    'estado':estado,
    'nombre':nombre,
    'urlImage':urlImage,
    'Canales':canales
  };


}