
import 'package:firebase_database/firebase_database.dart';
import 'package:universales_proyecto/model/user_chat.dart';

class FirebaseUserApi {

   FirebaseDatabase database = FirebaseDatabase.instance;
  
  Future<void> registrarUsuario(UserChat user) async {
    DatabaseReference usuarios = database.ref("Usuarios");
    final data = await usuarios.get();
    final referencia = await usuarios.child(user.uid).get();
    if(!referencia.exists){
      await administrarGeneral(user.uid);
      Map<String,dynamic> data = {user.uid:user.toJson()};
      usuarios.update(
        data
      );
    }    
  }

  Future<void> administrarGeneral(String uid) async{
    DatabaseReference general = database.ref("Canales").child("General");
    final snapshot = await general.get();
    if(snapshot.exists){
      final refCanal = general.child("usuarios");
      refCanal.update({uid:uid});
    }
  }

  DatabaseReference usuarios() {
    final d = database.ref("Usuarios");
    return database.ref("Usuarios");
  } 

  Future<DataSnapshot> listUser() async {
    return await database.ref("Usuarios").get();
  }

}