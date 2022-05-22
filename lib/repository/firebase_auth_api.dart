import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class FirebaseAuthAPI {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSingIn = GoogleSignIn();

  Future<UserCredential> signInGoogle() async {
    GoogleSignInAccount? googleSingInAccount = await googleSingIn.signIn();
    GoogleSignInAuthentication gSA = await googleSingInAccount!.authentication;

    UserCredential user = await auth.signInWithCredential(
      GoogleAuthProvider.credential(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken
      )
    );
    return user;
  }

  Future<UserCredential?> signInFacebook() async{
    List<String> permission = [];
    permission.add("email"); 
    permission.add("public_profile"); 
    permission.add("user_friends");

    final LoginResult result = await FacebookAuth.instance.login(permissions: permission);

    if(result.status == LoginStatus.success){
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      
      return await auth.signInWithCredential(credential);
    }else{
      print(result.status);
      print(result.message);
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    }

    return null;
  }

  Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {

    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = auth.currentUser;

    } on FirebaseAuthException catch (e) {
      
    } catch (e){

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
    await auth.signOut().then((value) => {
      print("Sección cerrada")
    });

    await googleSingIn.signOut();
    await FacebookAuth.instance.logOut();

  }

  

}