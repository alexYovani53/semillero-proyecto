import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:universales_proyecto/model/chanel_model.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';
import 'package:universales_proyecto/repository/firebase_user_api.dart';
import 'package:uuid/uuid.dart';

class FirebaseChanelApi {
  
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseUserApi userApi = FirebaseUserApi();

  StreamSubscription<DatabaseEvent>? subscription1;
  StreamSubscription<DatabaseEvent>? subscription2;

  StreamController<DatabaseEvent> controller = StreamController<DatabaseEvent>();
  var uuid = const Uuid();
   
  Future<void> crearCanal(ChanelModel chat, String idUser)  async{

    final list = database.ref("Canales");
    final uidChanel = uuid.v4().toString();
    await list.update({
      uidChanel:chat.toJson()
    });

    final mensaje = MesajeModel(
      texto: "canal creado!!", 
      fechaEnvio: DateTime.now().millisecondsSinceEpoch, 
      fechaEdicion: 0, 
      usuario: idUser, 
      type: "texto", 
      idMensaje: uuid.v4());
    enviarMensaje(mensaje, uidChanel);
    userApi.actualizarCanalUsuario(chat.usuarios,uidChanel);
  

  }

  Future<void> actualizarUsuarioCanal(Map<String,dynamic> usuarios,String idCanal,bool agregar,uidLogueado,nombreLogueado) async {    
    final usuariosDB = database.ref("Canales/$idCanal/usuarios");        
    usuarios.forEach((key, value) {
      if(agregar){
        usuariosDB.update({
          key:key
        });
      }else{
        usuariosDB.child(key).remove();
      }
    });
    userApi.actualizarUsuarioCanal2(usuarios,idCanal,agregar);

    final mensaje = MesajeModel(
      texto: "$nombreLogueado modifico a alguien", 
      fechaEnvio: DateTime.now().millisecondsSinceEpoch, 
      fechaEdicion: 0, 
      usuario: uidLogueado,
      type: "notification", 
      idMensaje: uuid.v4()
    );
    enviarMensaje(mensaje, idCanal);
  }

  Future<void> enviarMensaje(MesajeModel mensaje, String idCanal) async{
    final list = database.ref("Canales").child(idCanal);
    await list.child("mensajes").update({
      uuid.v4():mensaje.toJson()
    });
  }

  Future<void> actualizarMensaje(MesajeModel mensaje, String idCanal) async{
    if(mensaje.idMensaje==""){
      print("errrrrrrrrrrrrrrrrrrrrrrrroooor");
      return;
    }
    mensaje.fechaEdicion = DateTime.now().millisecondsSinceEpoch;
    final list = database.ref("Canales").child(idCanal);
    await list.child("mensajes").update({
      mensaje.idMensaje:mensaje.toJson()
    });
  }

  Future<DataSnapshot> recuperarMensajesChat(String idCanal) async {
    return database.ref("Canales/$idCanal/mensajes").orderByChild("fecha_envio").get();
  }

  Future<void> detenerSuscripcion() async{
    if(subscription1!=null) await subscription1!.cancel();      
    if(subscription2!=null) await subscription1!.cancel();
    controller = StreamController.broadcast();
  }

  //referencias
  DatabaseReference canalPorId(String idCanal) {
    return database.ref("Canales").child(idCanal);
  }
  
  DatabaseReference escucharMensajesChat(String idCanal){
    return database.ref("Canales").child(idCanal).child("mensajes");
  }

  void initOyente2(String idCanal){   
    controller = StreamController<DatabaseEvent>();
    final ref = database.ref("Canales").child(idCanal).child("mensajes");
    
    subscription1 = ref.orderByChild("fecha_envio").onChildAdded.listen((event) {
      if(controller.isClosed) return;
      controller.add(event);
    });

    subscription2 = ref.orderByChild("fecha_envio").onChildChanged.listen((event) {
      if(controller.isClosed) return;
      controller.add(event);
    });
  }

  Stream<DatabaseEvent> streamMensajesOrdenados2(String idCanal) {
    return controller.stream;
  }

  // FORMA 2 DE ESCUCHAR LOS MENSAJES. 
  Stream<DatabaseEvent> streamMensajesOrdenados (String idCanal){    
    final ref = database.ref("Canales").child(idCanal).child("mensajes");
    return ref.orderByChild("fecha_envio").onChildAdded;
  }


}