class MesajeModel {
  String idMensaje;
  String texto;
  int fechaEnvio;
  int fechaEdicion;
  String usuario;
  String type;

  MesajeModel({
    required this.texto,
    required this.fechaEnvio,
    required this.fechaEdicion,
    required this.usuario,
    required this.type,
    required this.idMensaje
  });

  static List<MesajeModel> mensajeList(Map<String,dynamic> json){
    List<MesajeModel> lista = [];
    json.forEach((key, value) {
      MesajeModel msj = MesajeModel.fromJson(value);
      msj.idMensaje = key;
      lista.add(msj);
    });
    return lista;
  }

  MesajeModel.fromJson(Map<String, dynamic> json)
      : idMensaje = "",
        texto = json['texto'],
        fechaEdicion = json['fecha_edicion']??0,
        fechaEnvio = json['fecha_envio']??1653357593687,
        usuario = json['usuario'],
        type = json['type'];

  Map<String, dynamic> toJson(){
    if(fechaEdicion>0){      
      return {
        'texto': texto,
        'fecha_envio':fechaEnvio,
        'fecha_edicion': fechaEdicion,
        'usuario':usuario,
        'type':type
      };
    }else{           
      return {
        'texto': texto,
        'fecha_envio':fechaEnvio,
        'usuario':usuario,
        'type':type
      };
    }
  }
}