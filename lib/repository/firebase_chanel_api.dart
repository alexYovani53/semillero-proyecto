import 'package:firebase_database/firebase_database.dart';
import 'package:universales_proyecto/model/chanel_model.dart';
import 'package:universales_proyecto/repository/firebase_user_api.dart';
import 'package:uuid/uuid.dart';

class FirebaseChanelApi {
  
   FirebaseDatabase database = FirebaseDatabase.instance;
   FirebaseUserApi userApi = FirebaseUserApi();


  var uuid = Uuid();
   
   Future<void> crearCanal(ChanelModel chat)  async{

    final list = database.ref("Canales");
    final uidChanel = uuid.v4().toString();
    await list.update({
      uidChanel:chat.toJson()
    });

    userApi.actualizarUsuarioCanal(chat.usuarios,uidChanel);

   }
  
}