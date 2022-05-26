

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';
import 'package:universales_proyecto/repository/firebase_chanel_repository.dart';
import 'package:universales_proyecto/repository/firebase_users_repository.dart';
import 'package:uuid/uuid.dart';

part 'canal_event.dart';
part 'canal_state.dart';

class CanalBloc extends Bloc<CanalEvent,CanalState>{

  final firebaseUserRepository = FirebaseUsersRepository();
  final firebaseChanelRepository = FirebaseChanelRepository();

  
  Future<DataSnapshot> listUser() => firebaseUserRepository.listUser();

  DatabaseReference streamCanalesUser (String uid) => firebaseUserRepository.canalesUsuario(uid);
  DatabaseReference streamCanalUser(String idCanal) => firebaseChanelRepository.canalPorId(idCanal);

  Future<DataSnapshot> recuperarMensajesChat(String idCanal )=>firebaseChanelRepository.recuperarMensajesChat(idCanal);


  Stream<DatabaseEvent> streamMensajesOrdenados(String idCanal) => firebaseChanelRepository.streamMensajesOrdenados(idCanal);
  Stream<DatabaseEvent> streamMensajesOrdenados2(String idCanal) => firebaseChanelRepository.streamMensajesOrdenados2(idCanal);



  CanalBloc():super(CanalInitState()){

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



}