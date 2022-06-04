import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthProvider {

  
  LocalAuthProvider._privateConstructor();

  static final LocalAuthProvider shared = LocalAuthProvider._privateConstructor();
  final _auth = LocalAuthentication();

  LocalAuthentication get getAuth => _auth;

  Future<bool> hasBiometrics() async {
    const AndroidAuthMessages(
            signInTitle: 'Oops! Biometric authentication required!',
            cancelButton: 'No thanks',
          );
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async{
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException  catch (e) {
      return <BiometricType>[];
    }
  }

  Future<bool> authenticateBiometrics() async{ 

    //final isAvailable = await hasBiometrics();    
    //if(!isAvailable) return true;

    try {
      return await _auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Oops! Biometric authentication required!',
            cancelButton: 'No thanks', 
            // biometricHint:  localizations.dictionary(Strings.verifiqueHuella),
            // cancelButton: localizations.dictionary(Strings.botonCancelar),
          ),
        ]
      );
    } on PlatformException  catch (e) {
      if(e.code == auth_error.notEnrolled){
        
      }
      else if( e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut){
        print("BLOQUEADO");
      }
      else if(e.code == auth_error.notAvailable){
          
      }
      return false;
    }

  }


}