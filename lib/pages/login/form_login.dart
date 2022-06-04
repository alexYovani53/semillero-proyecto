
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/local_auth_provider.dart';
import 'package:universales_proyecto/utils/app_messages.dart';
import 'package:universales_proyecto/utils/app_preferences.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/app_types_input.dart';
import 'package:universales_proyecto/widget/text_form_field_custom.dart';


import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';


import 'package:encrypt/encrypt.dart' as encriptador;

class FormLogin extends StatefulWidget {
  
  FormLogin({ Key? key }) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  final keys =  encriptador.Key.fromUtf8("12345678901234567890123456789012");
  final iv = encriptador.IV.fromLength(16);

  final formKey = GlobalKey<FormState>();
  final controllerCorreo = TextEditingController();
  final controllerContrasena = TextEditingController();

  late ThemeProvider theme;
  late UserBloc bloc;

  late LocalizationsApp diccionary;

  bool isCheckedRemember = false;

  @override
  void initState(){
    _loadUserEmailPassword();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    theme = Provider.of<ThemeProvider>(context);
    bloc = BlocProvider.of<UserBloc>(context);

    final languajeProvider = Provider.of<LanguajeProvider>(context);
    diccionary = LocalizationsApp(languajeProvider.getLanguaje);

    return Container(

      height: 584,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 59,top: 40),
            child: Form(
              key: formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diccionary.diccionario(Strings.initEmail),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(
                    width: 310,
                    child: TextFormFieldCustom(
                      hintText:  diccionary.diccionario(Strings.initEmail),
                      icono: Icons.email,tipo: TypesInput.CORREO,
                      controller: controllerCorreo,
                      ocultar: false,)
                  ),
                  SizedBox(height: 20,),
                  Text(                    
                    diccionary.diccionario(Strings.initPassword),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(
                    width: 310,
                    child: TextFormFieldCustom(
                      hintText:  diccionary.diccionario(Strings.initPassword),
                      icono: Icons.password,
                      tipo: TypesInput.TEXTO,
                      controller: controllerContrasena,ocultar: true,)
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25,bottom: 25),
                    width: 310,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isCheckedRemember, 
                              onChanged: _handleRemember
                            ),
                            Text(diccionary.diccionario(Strings.initRemember),
                              style: TextStyle(
                                color: forgotPasswordText,
                                fontSize: 16,
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.w500
                              ),
                            )
                            
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            if (formKey.currentState!.validate()){
                              bloc.add(UserEventLoginEmailPass(correo: controllerCorreo.text,password: controllerContrasena.text));
                            }else{
                              showFlushBar("Error","Formulario no valido");
                            }
                          },
                          child: Container(
                            width: 99,
                            height: 35,
                            decoration: BoxDecoration(
                              color: signInButton,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                              )
                            ),
                            child: Center(
                              child: Text(
                                diccionary.diccionario(Strings.initButton),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 310,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(
                          diccionary.diccionario(Strings.initOr),
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins-Regular',
                            color: hintTextColor )
                        )
                      ] 
                          ,
                    ),
                  ),
                  Container(
                    width: 310,
                    padding: EdgeInsets.only(left: 40,right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){                            
                            bloc.add(userEventLoginFacebook());
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 59,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))
                            ),
                            child: Image.asset(
                              'assets/images/iconoFacebook.png',
                              width: 20,
                              height: 21,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            bloc.add(userEventLoginGoogle());
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 59,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(100)
                            ),
                            child: Image.asset(
                              'assets/images/iconoGoogle.png',
                              width: 20,
                              height: 21,
                            ),
                          ),
                        ),
                        
                        
                      ]
                    ),
                  ),
                  
                ],
              ),
            ),
          )
        ],
      )

    );
  }

  encryptarTexto(String text){
    final encrypter = encriptador.Encrypter(encriptador.AES(keys));
    final encryptedData = encrypter.encrypt(text,iv: iv);
    return encryptedData.base64;
  }

  desencryptarTexto(String text){
    final encrypter = encriptador.Encrypter(encriptador.AES(keys));
    final decryptedData = encrypter.decrypt(encriptador.Encrypted.from64(text));
    return decryptedData;
  }

  showFlushBar(String titulo, String texto){
    Flushbar(
      title:  titulo,
      message:  texto,
      duration:  const Duration(seconds: 6),            
      margin:    const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      flushbarPosition: FlushbarPosition.TOP,
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);
  }
  
  Future<bool> hasBiometrics() async {

    try {
      return await LocalAuthProvider.shared.getAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async{
    try {
      return await LocalAuthProvider.shared.getAuth.getAvailableBiometrics();
    } on PlatformException  catch (e) {
      return <BiometricType>[];
    }
  }

  Future<bool> authenticateBiometrics() async{ 

    //final isAvailable = await hasBiometrics();    
    //if(!isAvailable) return true;
    
    final Title = diccionary.diccionario(Strings.biometricsTituloDialog);

    try {
      return await LocalAuthProvider.shared.getAuth.authenticate(
        localizedReason: diccionary.diccionario(Strings.biometricsLocalizedReason),
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: diccionary.diccionario(Strings.biometricsSingInTitle),
            cancelButton: diccionary.diccionario(Strings.biometricsCancelButton), 
            biometricHint:  diccionary.diccionario(Strings.biometricsBiometricHint),
          ),
        ]
      );
    } on PlatformException  catch (e) {
      if(e.code == auth_error.notEnrolled){
        showFlushBar(Title, diccionary.diccionario(Strings.biometricsNoConfigurado));
        // AppMessages.shared.showAlertDialog(context, "Biometria", "Desea configurar su huella", () { 
        //    OpenSettings.openSecuritySetting();
        // });
      }
      else if( e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut){
        showFlushBar(Title, diccionary.diccionario(Strings.biometricsBloqueado));
      }
      else if(e.code == auth_error.notAvailable){
        showFlushBar(Title, diccionary.diccionario(Strings.biometricsNoDisponible));
      }
      return false;
    }

  }

  void _handleRemember(bool? value) async {
    final valor = await hasBiometrics();
    if(valor){
      setState(() {
        isCheckedRemember = value!;
      });
    }else{      
      setState(() {
        isCheckedRemember = false;
      });
      
      AppMessages.shared.showAlertDialog(context,"!Biometria!","No se cuenta con sensor de huella para usar esta funcionalidad",(){});
      
    }

  }
  
  Future<void> saveSharedPreference(bool checked) async {
    
    if(!checked) {
      await SharedPreferences.getInstance().then(
        (prefs) async {
          if(prefs.containsKey("remember_me")) await prefs.remove("remember_me");
          if(prefs.containsKey("email")) await prefs.remove("email");
          if(prefs.containsKey("password")) await prefs.remove("password");
        },
      );
      return;
    }

    final passwordEncrypted = encryptarTexto(controllerContrasena.text);
    showFlushBar(passwordEncrypted,"Contraseña Encriptada");

    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", checked);
        prefs.setString('email', controllerCorreo.text);
        prefs.setString('password', passwordEncrypted);
      },
    );
  }

 void _loadUserEmailPassword() async {
    try {

      AppPreferences.shared.contains(AppPreferences.APP_REMEMBER_ME).then((bool value) async {
        if (value){
          String email = await AppPreferences.shared.getString(AppPreferences.APP_EMAIL) ?? "";
          bool remember = await AppPreferences.shared.getBool(AppPreferences.APP_REMEMBER_ME) ?? false;

          if (remember) {
            setState(() {
              isCheckedRemember = true;
            });
            controllerCorreo.text = email ;
          }
        }
      });

    } catch (e) {
      print(e);
    }
  } 
  Future<void> loadContrasena() async{
  
    try{

      if (isCheckedRemember && controllerContrasena.text == ""){
          String password = await AppPreferences.shared.getString(AppPreferences.APP_PASSWORD) ?? "";
          bool remember = await AppPreferences.shared.getBool(AppPreferences.APP_REMEMBER_ME) ?? false;

        if (remember) {
          setState(() {
            isCheckedRemember = true;
          });
          
          authenticateBiometrics().then((statusOk){
            if(statusOk){
              final decryptedPass = encryptarTexto(password);
              controllerContrasena.text = decryptedPass;
            }
          });

        }
      }
    } catch (e) {
      print(e);
    }
  }
}