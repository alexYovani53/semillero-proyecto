import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universales_proyecto/model/user_sesion.dart';
import 'package:universales_proyecto/repository/firebase_auth_repository.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent,UserState>{

  final auth_repositori = AuthRepository();
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;

  UserSesion? sesion;


  Future<User?> usuarioActual() async{
    User? us = FirebaseAuth.instance.currentUser;
    return us;
  }
  
  UserBloc( ) : super(UserInitState()){

    on<UserEvent>((event, emit)  async {
    });

    on<UserEventCreateAcount>((event, emit) async{
      User? usuario = await auth_repositori.registerUsingEmailPassword("yovani",event.correo,event.password);
      if(usuario!= null){
        print(usuario.email);
      }
    });

    on<UserEventLoginEmailPass>((event, emit) async {
      var user = await auth_repositori.loginUsingEmailPassword(event.correo, event.password);
      iniciarUsuario(user);
    });
    
    on<UserEventCarcarData>((event, emit) async {
      var user = await usuarioActual();
      iniciarUsuario(user);
    });

    on<userEventLogOut>((event,emit)async{
      await auth_repositori.signOut();
      sesion = null;
    });

    on<userEventLoginGoogle>((event,emit)async {
      await auth_repositori.signInGoogle();
    });

    
    on<userEventLoginFacebook>((event,emit)async {
      await auth_repositori.signInFacebook();
    });

  }


  Future<void> iniciarUsuario(user) async{
    await Future.delayed(const Duration(seconds: 1), () {
      if(user!=null){        

        sesion = UserSesion(
          uid: user.uid, 
          name: user.displayName??"", 
          email: user.email ?? "", 
          photoURL: user.photoURL??""
        );
      }
    });  
  }

}