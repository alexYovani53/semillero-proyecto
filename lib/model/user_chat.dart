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

  List<UserChat> usuarios(Map<String,dynamic> data){
    List<UserChat> lista= [];
    data.forEach((key, value) {
      lista.add(UserChat.fromJson(value));
    });
    return lista;
  }

  UserChat.fromJson(Map<String, dynamic> json)
      : uid = json['uid']??"",
        change = json['change']??false,
        correo = json['correo']??"undefined",
        estado = json['estado']??false,
        nombre = json['nombre']??"undefined",
        urlImage = json['urlImage']??"",        
        canales = json['Canales']??{};

  Map<String, dynamic> toJson() => {
    'change': change,
    'correo': correo,
    'estado':estado,
    'nombre':nombre,
    'urlImage':urlImage,
    'Canales':canales
  };

  static Map<String,dynamic> listToJson(List<UserChat> lista){
    Map<String,dynamic> json = {};
    lista.forEach((element) {
      json[element.uid] = element.uid ;
    });
    return json;
  }


}