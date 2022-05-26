
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universales_proyecto/repository/firebase_users_repository.dart';

part 'user_chat_event.dart';
part 'user_chat_state.dart';

class UserChatBloc extends Bloc<UserChatEvent,UserChatState>{
  
  final user_chat_repository = FirebaseUsersRepository();

  DatabaseReference get usuarios => user_chat_repository.usuarios();

  
  UserChatBloc() : super(UserChatInitState()){
    on((event, emit) {
      print(event.toString());
    });
  }
  
}