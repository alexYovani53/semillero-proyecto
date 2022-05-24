class MesajeModel {
  String texto;
  String fechaEnvio;
  String fechaEdicion;
  String usuario;

  MesajeModel({
    required this.texto,
    required this.fechaEnvio,
    required this.fechaEdicion,
    required this.usuario
  });

  MesajeModel.fromJson(Map<String, dynamic> json)
      : texto = json['texto'],
        fechaEdicion = json['fechaEdicion']??"",
        fechaEnvio = json['fechaEnvio'],
        usuario = json['usuario'];

  Map<String, dynamic> toJson() => {
    'texto': texto,
    'fechaEnvio':fechaEnvio,
    'fechaEdicion': fechaEdicion,
    'usuario':usuario
  };
}