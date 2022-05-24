import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/repository/firebase_user_api.dart';


class FirebaseAuthAPI {
  final FirebaseUserApi firebaseUserApi = FirebaseUserApi();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSingIn = GoogleSignIn();

  String mensajeError = "";
  String titulo = "";

  Future<UserCredential> signInGoogle() async {
    GoogleSignInAccount? googleSingInAccount = await googleSingIn.signIn();
    GoogleSignInAuthentication gSA = await googleSingInAccount!.authentication;

    UserCredential user = await auth.signInWithCredential(
      GoogleAuthProvider.credential(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken
      )
    );

    UserChat chat = UserChat(
      uid: user.user!.uid, 
      change: false, 
      correo: user.user!.email??"",
      estado: true, 
      nombre: user.user!.displayName??"",
      urlImage: user.user!.photoURL??"",
      canales: {});

    firebaseUserApi.registrarUsuario(chat);

 
    return user;
  }

  Future<UserCredential?> signInFacebook() async{
    
    reiniciar();
    List<String> permission = ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'];

    final LoginResult result = await FacebookAuth.instance.login(permissions: permission);

    if(result.status == LoginStatus.success){
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);      
      return await auth.signInWithCredential(credential);
    }
    
    titulo = "Facebook";
    mensajeError = result.message!;    
    return null;
  }

  Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {

    reiniciar();
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {      
      titulo= "error";
      mensajeError = e.message!;
    } catch (er){
      titulo= "error";
      mensajeError = er.toString();
    }
    
    return user;
  }

  Future<User?> actualizarPerfil({
    String? userName,
    String? password
  }) async{

    
    User? user = auth.currentUser;    
    if(password!=null){  
      try {
        await user!.updatePassword(password);      
        await user.reload();
        user = auth.currentUser;
      }catch(e){
        print("Error");
      }
    }

    if(userName!=null){    
      try {
        await user!.updateDisplayName(userName);        
        await user.reload();      
        user = auth.currentUser;
      }catch(e){
        print("Error");
      }
    }

    return user;
  }

  Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;

      UserChat chat = UserChat(
        uid: user!.uid, 
        change: false, 
        correo: user.email??"",
        estado: true, 
        nombre: user.displayName??"",
        urlImage: user.photoURL??"",
        canales: {});

        firebaseUserApi.registrarUsuario(chat);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<void> signOut() async {
    await auth.signOut().then((value) => {});
    await googleSingIn.signOut();
    await FacebookAuth.instance.logOut();

  }

  void reiniciar(){
    titulo = "";
    mensajeError= "";
  }
  

}