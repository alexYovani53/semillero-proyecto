
import 'package:firebase_database/firebase_database.dart';
import 'package:universales_proyecto/model/chanel_model.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';
import 'package:universales_proyecto/repository/firebase_chanel_api.dart';

class FirebaseChanelRepository {

  final firebaseChanelApi = FirebaseChanelApi();

  
  DatabaseReference canalPorId(String idCanal) => firebaseChanelApi.canalPorId(idCanal);
  Future<void> crearCanal(ChanelModel chat,String idUser) => firebaseChanelApi.crearCanal(chat,idUser);
  Future<void> enviarMensaje(MesajeModel mensaje, String idCanal) => firebaseChanelApi.enviarMensaje(mensaje, idCanal);
  Future<DataSnapshot> recuperarMensajesChat( String idCanal) => firebaseChanelApi.recuperarMensajesChat(idCanal);
    

  Stream<DatabaseEvent> streamMensajesOrdenados(String idCanal) => firebaseChanelApi.streamMensajesOrdenados(idCanal);
  Stream<DatabaseEvent> streamMensajesOrdenados2(String idCanal) => firebaseChanelApi.streamMensajesOrdenados2(idCanal);

  void initOyente(String idCanal)=> firebaseChanelApi.initOyente(idCanal);
   
  Future<void> actualizarUsuarioCanal(Map<String,dynamic> usuarios,String idCanal,bool agregar, String uidLogueado, String nombreLogueado)
    => firebaseChanelApi.actualizarUsuarioCanal(usuarios, idCanal, agregar,uidLogueado,nombreLogueado);
}