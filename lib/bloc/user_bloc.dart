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

  Stream<User?> streamUser = FirebaseAuth.instance.userChanges();
  Stream<User?> get authUser => streamUser;


  UserSesion? sesion;


  Future<User?> usuarioActual() async{
    User? us = FirebaseAuth.instance.currentUser;
    return us;
  }
  
  UserBloc( ) : super(UserInitState()){

    on<UserEvent>((event, emit)  async {
    });

    on<userEventUpdateProfile>((event, emit)  async {
      await auth_repositori.actualizarPerfil(event.usuario,event.password);
      var user = await usuarioActual();
      await iniciarUsuario(user);
    });


    on<UserEventCreateAcount>((event, emit) async{
      User? usuario = await auth_repositori.registerUsingEmailPassword("yovani",event.correo,event.password);
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


    on<UserEventPageEdit>((event,emit)async {
      print("emitiendo evento");
      emit(UserEditState());
    });
    on<UserEventPageProfile>((event,emit)async {
      emit(UserProfileState());
    });
    on<UserEventPageSettings>((event,emit)async {
      print("emitiendo evento");
      emit(UserSettingsState());
    });
    on<UserEventPageChat>((event,emit)async {
      print("emitiendo evento");
      emit(UserChatState());
    });

  }


  Future<void> iniciarUsuario(user) async{
    if(user!=null){        

      sesion = UserSesion(
        uid: user.uid, 
        name: user.displayName??"", 
        email: user.email ?? "", 
        photoURL: user.photoURL??""
      );
    }

    print("Se actualizoooooooooooooooooooooooooooo");

  }

}