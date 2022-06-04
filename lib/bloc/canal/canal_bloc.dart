


import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/repository/firebase_chanel_repository.dart';
import 'package:universales_proyecto/repository/firebase_users_repository.dart';
import 'package:uuid/uuid.dart';

part 'canal_event.dart';
part 'canal_state.dart';

class CanalBloc extends Bloc<CanalEvent,CanalState>{

  final firebaseUserRepository = FirebaseUsersRepository();
  final firebaseChanelRepository = FirebaseChanelRepository();

  
  Future<DataSnapshot> infoUser(String uid) => firebaseUserRepository.infoUser(uid);
  Future<DataSnapshot> listUser() => firebaseUserRepository.listUser();

  DatabaseReference streamCanalesUser (String uid) => firebaseUserRepository.canalesUsuario(uid);
  DatabaseReference streamCanalUser(String idCanal) => firebaseChanelRepository.canalPorId(idCanal);

  Future<DataSnapshot> recuperarMensajesChat(String idCanal )=>firebaseChanelRepository.recuperarMensajesChat(idCanal);


  Stream<DatabaseEvent> streamMensajesOrdenados(String idCanal) => firebaseChanelRepository.streamMensajesOrdenados(idCanal);
  Stream<DatabaseEvent> streamMensajesOrdenados2(String idCanal) => firebaseChanelRepository.streamMensajesOrdenados2(idCanal);


  static List<UserChat> usuariosGlobalChats = [
    UserChat(uid: "", change: false, correo: "", estado: false, nombre: "", urlImage: "", canales: {})
  ];

  List<UserChat> get lista => usuariosGlobalChats;

  CanalBloc():super(CanalInitState()){



    on<CanalInitStream>((event, emit) async {
      await firebaseChanelRepository.detenerSuscripcion();
      firebaseChanelRepository.initOyente2(event.idCanal);
    });

    on<CanalEliminarOyentes>((event, emit) => {
      firebaseChanelRepository.detenerSuscripcion()
    });

    on<CanalActualizarMensaje>((event, emit){

      final mensaje = event.mensaje;
      firebaseChanelRepository.actualizarMensaje(mensaje, event.idCanal);

    });
    on<CanalEnviarMensajeEvent>((event, emit){

      final mensaje = MesajeModel(
        texto: event.texto, 
        fechaEnvio: DateTime.now().millisecondsSinceEpoch, 
        fechaEdicion: 0, 
        usuario: event.usuario, 
        type: event.type, 
        idMensaje: ""
      );

      firebaseChanelRepository.enviarMensaje(mensaje, event.idCanal);

    });

    on<CanalAgregarUsuarioEvent>((event,emit) async{      
      Map<String,dynamic> usuarios = {event.uidUsuario:event.uidUsuario};
      await firebaseChanelRepository.actualizarUsuarioCanal(
        usuarios,
        event.idCanal,
        true,
        event.uidLogueado,
        event.nombreLogueado
      );
    });

    on<CanalEliminUsuarioEvent>((event,emit) async{
      Map<String,dynamic> usuarios = {event.uidUsuario:event.uidUsuario};

      await firebaseChanelRepository.actualizarUsuarioCanal(
        usuarios,
        event.idCanal,
        false,
        event.uidLogueado,
        event.nombreLogueado
      );
    });

  }

  @override
  Future<void> close(){
    firebaseChanelRepository.detenerSuscripcion();
    return super.close();
  }


}