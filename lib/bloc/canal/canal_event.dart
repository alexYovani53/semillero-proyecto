
part of 'canal_bloc.dart';

abstract class CanalEvent extends Equatable {
 @override
  List<Object?> get props =>[];
}

class CanalActualizarMensaje extends CanalEvent{
  String idCanal;
  MesajeModel mensaje;
  CanalActualizarMensaje({
    required this.idCanal,
    required this.mensaje
  });
  
 @override
  List<Object?> get props =>[idCanal,mensaje];
}

class CanalEnviarMensajeEvent extends CanalEvent{
  String texto;
  String type;
  String usuario;
  String idCanal;

  CanalEnviarMensajeEvent({
    required this.texto,
    required this.type,
    required this.usuario,
    required this.idCanal
  });

  @override
  List<Object?> get props => [texto,type,usuario,idCanal];

}

class CanalAgregarUsuarioEvent extends CanalEvent{
  String uidUsuario;
  String uidLogueado;
  String nombreLogueado;
  String idCanal;
  CanalAgregarUsuarioEvent({
    required this.uidUsuario,
    required this.uidLogueado,
    required this.idCanal,
    required this.nombreLogueado
  });

  @override
  List<Object?> get props => [uidUsuario,uidLogueado,idCanal, nombreLogueado];

}

class CanalEliminUsuarioEvent extends  CanalEvent{
  String uidUsuario;
  String uidLogueado;
  String idCanal;
  String nombreLogueado;
  CanalEliminUsuarioEvent({
    required this.uidUsuario,
    required this.uidLogueado,
    required this.idCanal,
    required this.nombreLogueado
  });

  @override
  List<Object?> get props => [uidUsuario,uidLogueado,idCanal,nombreLogueado];

}

class CanalInitStream extends CanalEvent{
  String idCanal;
  CanalInitStream({
    required this.idCanal
  });
  @override
  List<Object?> get props => [idCanal];
}

class CanalEliminarOyentes extends CanalEvent{

  @override
  List<Object?> get props => [];
}

