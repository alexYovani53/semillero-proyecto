

import 'package:firebase_database/firebase_database.dart';
import 'package:universales_proyecto/repository/firebase_user_api.dart';

class FirebaseUsersRepository {

   
  final FirebaseUserApi api = FirebaseUserApi();

  DatabaseReference usuarios() => api.usuarios();

  Future<DataSnapshot> listUser() => api.listUser();
}