
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/utils/config.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/app_types_input.dart';
import 'package:universales_proyecto/widget/text_form_field_custom.dart';

class FormLogin extends StatefulWidget {
  
  FormLogin({ Key? key }) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  final formKey = GlobalKey<FormState>();
  final controllerCorreo = TextEditingController();
  final controllerContrasena = TextEditingController();

  late ThemeProvider theme;
  late UserBloc bloc;


  @override
  Widget build(BuildContext context) {

    theme = Provider.of<ThemeProvider>(context);
    bloc = BlocProvider.of<UserBloc>(context);

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
                    'Correo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(
                    width: 310,
                    child: TextFormFieldCustom(hintText: "correo",icono: Icons.email,tipo: TypesInput.CORREO,controller: controllerCorreo,ocultar: false,)
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(
                    width: 310,
                    child: TextFormFieldCustom(hintText: "correo",icono: Icons.password,tipo: TypesInput.TEXTO,controller: controllerContrasena,ocultar: true,)
                  ,
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
                              value: true, 
                              onChanged: (bool? value){}
                            ),
                            Text(
                              'Remember Me',
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
                                "Login",
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
                            "or",
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