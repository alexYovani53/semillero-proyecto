
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/pages/login/config.dart';
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

  final controllerContrasena = TextEditingController();    

  late ThemeProvider theme;

  late UserBloc bloc;

  late LocalizationsApp diccionary;

  @override
  Widget build(BuildContext context) {

    theme = Provider.of<ThemeProvider>(context);
    bloc = BlocProvider.of<UserBloc>(context);
    LanguajeProvider languajeProvider = Provider.of<LanguajeProvider>(context);
    LocalizationsApp diccionary = LocalizationsApp(languajeProvider.getLanguaje);

    return Container(

      height: 584,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 59,top: 99),
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
                        child: TextFormFieldCustom(hintText: 'ingrese un correo',icono: Icons.email,tipo: TypesInput.CORREO,controller: controllerCorreo,)
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
                        child: TextFormFieldCustom(hintText: 'ingrese un correo',icono: Icons.password,tipo: TypesInput.TEXTO,controller: controllerContrasena,)
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 55,bottom: 55),
                        padding: EdgeInsets.only(left: 150),
                        width: 310,
                        child: InkWell(
                          onTap: (){

                            if(formKey.currentState!.validate()){                                
                              bloc.add(UserEventCreateAcount(
                                correo: controllerCorreo.text,
                                password: controllerContrasena.text
                              ));
                            }
                          },
                          child: Container(
                            width: 99,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: signInButton,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                              )
                            ),
                            child: Center(
                              child: Text(
                                "Registrar",
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
                        child: Text("Crear cuenta con "),
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
                                border:  Border.all(color:signInBox),
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
                            "or",
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
                                border:  Border.all(color:signInBox ),
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
}