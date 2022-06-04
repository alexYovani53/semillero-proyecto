
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/utils/app_types_input.dart';
import 'package:universales_proyecto/widget/text_form_field_custom.dart';

class FormRegister extends StatefulWidget {
  
  FormRegister({ Key? key }) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final formKey = GlobalKey<FormState>();  

  final controllerCorreo = TextEditingController();
  final controllerUserName = TextEditingController();
  final controllerContrasena = TextEditingController();    

  late ThemeProvider theme;

  late UserBloc bloc;

  late LocalizationsApp diccionary;

  @override
  Widget build(BuildContext context) {

    theme = Provider.of<ThemeProvider>(context);
    bloc = BlocProvider.of<UserBloc>(context);

    LanguajeProvider languajeProvider = Provider.of<LanguajeProvider>(context);
    diccionary = LocalizationsApp(languajeProvider.getLanguaje);

    return Container(

      height: 584,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 59,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(                  
                        diccionary.diccionario(Strings.initEmail),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(
                        width: 310,
                        child: TextFormFieldCustom(hintText: 'ingrese un correo',icono: Icons.email,tipo: TypesInput.CORREO,controller: controllerCorreo,ocultar: false,)
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        diccionary.diccionario(Strings.initUserName),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(
                        width: 310,
                        child: TextFormFieldCustom(hintText: 'ingrese un usuario',icono: Icons.password,tipo: TypesInput.TEXTO,controller: controllerUserName,ocultar:false)
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        diccionary.diccionario(Strings.initPassword),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(
                        width: 310,
                        child: TextFormFieldCustom(hintText: 'ingrese una contraseña',icono: Icons.password,tipo: TypesInput.TEXTO,controller: controllerContrasena,ocultar:true)
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        width: 310,
                        child: InkWell(
                          onTap: () async {

                            if(formKey.currentState!.validate()){                                
                              bloc.add(UserEventCreateAcount(
                                correo: controllerCorreo.text,
                                password: controllerContrasena.text
                              ));
                            }else{
                              showFlushBar("Formulario", "Verifique los campos");
                              await Future.delayed(Duration(seconds:2),(){
                                formKey.currentState!.reset();
                              });
                            }
                          },
                          child: Container(
                            width: 125,
                            height: 45,
                            decoration: const BoxDecoration(
                              color: signInButton,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(
                              child: Text(
                                diccionary.diccionario(Strings.initRegistrar),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 0.5,endIndent: 75 ,
                      color: inputBorder,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      width: 310,
                      child: Center(
                        child: Text(diccionary.diccionario(Strings.initCrearCuenta)),
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
                          Text(
                            diccionary.diccionario(Strings.initOr),
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins-Regular',
                              color: hintTextColor )
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
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                                )
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
                )
              ],
            ),
          )
        ],
      )

    );
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
}