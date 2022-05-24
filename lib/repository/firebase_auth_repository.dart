import 'package:firebase_auth/firebase_auth.dart';
import 'package:universales_proyecto/repository/firebase_auth_api.dart';

class FirebaseAuthRepository {

  final _firebaseAuthAPI_ = FirebaseAuthAPI();

  Future<UserCredential> signInGoogle() => _firebaseAuthAPI_.signInGoogle();
  Future<UserCredential?> signInFacebook() => _firebaseAuthAPI_.signInFacebook();

  Future<void> signOut() => _firebaseAuthAPI_.signOut();

  String get mensajeError => _firebaseAuthAPI_.mensajeError;
  String get mensajeTitulo => _firebaseAuthAPI_.titulo;


  Future<User?> registerUsingEmailPassword(
    String name,  
    String email, 
    String password) => 
    _firebaseAuthAPI_.registerUsingEmailPassword(  name: name,   email: email,   password: password);

  Future<User?> loginUsingEmailPassword(
    String email, 
    String password) => 
    _firebaseAuthAPI_.loginUsingEmailPassword(  email: email,   password: password);

  Future<User?> actualizarPerfil(
    String? userName, 
    String? password) => 
    _firebaseAuthAPI_.actualizarPerfil(  userName: userName,   password: password);


}