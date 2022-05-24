

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/localizations/localizations.dart';
import 'package:universales_proyecto/provider/languaje_provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/app_string.dart';
import 'package:universales_proyecto/utils/app_types_input.dart';
import 'package:universales_proyecto/widget/text_form_field_custom.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final controllerUserName = TextEditingController();
  final controllerContrasena = TextEditingController();

  final profileHeight = 144.0;
  int _index = 0;

  late LocalizationsApp diccionario;
  late ThemeProvider theme;
  late UserBloc bloc;

  bool actualizacion  = false;

  String nombreUser = "";

  @override
  Widget build(BuildContext context) {

    final LanguajeProvider lang = Provider.of<LanguajeProvider>(context,listen: false);
    bloc = BlocProvider.of<UserBloc>(context);
    diccionario = LocalizationsApp(lang.getLanguaje);
    theme =Provider.of<ThemeProvider>(context,listen: false);

    nombreUser = bloc.sesion!.name;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top:20),
        child: FloatingActionButton(
          heroTag: "otro boton",
          child: Icon(Icons.arrow_circle_left_outlined),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blueGrey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
          ),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          diccionario.diccionario(Strings.editingText1),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 28,
                            fontFamily: "lato",
                            color:Colors.yellow[700]
                          ),
                        ),
                        Text(
                          diccionario.diccionario(Strings.editingText2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            fontFamily: "lato",
                            color:Colors.yellow[700]
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(                        
                          diccionario.diccionario(Strings.editingSubtext),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              
              SizedBox(height: 150,),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color:   Color.fromARGB(255, 22, 90, 161),
                        borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(40),
                          topRight:Radius.circular(40)
                        )
                      ),
                    ),                  
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: const BoxDecoration(
                        color:   Color.fromARGB(255, 80, 128, 180),
                        borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(40),
                          topRight:Radius.circular(40)
                        )
                      ),
                    ),
                    Positioned(
                      top: -profileHeight/2,
                      child: Container(
                        height: profileHeight,
                        child: profileImage()
                      ),
                    ),

                    Positioned(
                      top:profileHeight/2 + 10,
                      child: Text(                     
                        nombreUser,
                        style:TextStyle(
                          fontSize: 20,fontWeight: FontWeight.w500,color: Colors.amber[600]
                        ) ,
                      )
                    ),
                    Positioned(
                      top:profileHeight/2 + 30,
                      child: Text(
                        bloc.sesion!.email,
                        style:const TextStyle(
                          fontSize: 18,fontWeight: FontWeight.w500,color: Colors.lightGreen
                        ) ,
                      )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 250,
                      child:Theme(
                        data: ThemeData(
                          canvasColor: Color.fromARGB(255, 61, 126, 196),
                                colorScheme: Theme.of(context).colorScheme.copyWith(
                                  background: Colors.red,
                                ),
                        ),
                        child: steper(),
                      ) 
                    ),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
 Widget steper(){
    return  Stepper(
      type: StepperType.horizontal,
      physics : ScrollPhysics(),
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      controlsBuilder: (BuildContext context, ControlsDetails controls){
        return Row(
          children: [
            // ElevatedButton(
            //   child: Text("Continuar"),
            //   onPressed: controls.onStepContinue
            // ),            
            // ElevatedButton(
            //   child: Text("Continuar"),
            //   onPressed: controls.onStepContinue
            // )
          ],
        );
      },

      steps: <Step>[
        Step(

          title: Text(diccionario.diccionario(Strings.editingUserName),),
          content: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  TextFormFieldCustom(
                    hintText: diccionario.diccionario(Strings.editingInputUser),
                    icono: Icons.person_add,
                    ocultar: false,
                    tipo: TypesInput.TEXTO,
                    controller: controllerUserName,
                  ),
                  FloatingActionButton(
                    heroTag: "obotonUser",
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 40,
                    ),
                    onPressed: () async{                      
                      bloc.add(userEventUpdateProfile(usuario: controllerUserName.text));               
                      setState(() {                          
                        nombreUser = controllerUserName.text;
                        controllerUserName.clear();  
                      });
                        FocusScope.of(context).unfocus();
                    }
                  )
                ],
              )
          ),
        ),
        Step(
          title: Text(diccionario.diccionario(Strings.editingPassword)),
          content: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  TextFormFieldCustom(
                    hintText:diccionario.diccionario(Strings.editingInputPassword),
                    icono: Icons.person_add,
                    ocultar: true,
                    tipo: TypesInput.TEXTO,
                    controller: controllerContrasena,
                  ),
                  FloatingActionButton(
                    heroTag: "heroContrasena",
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 40,
                    ),
                    onPressed: () async{
                      bloc.add(userEventUpdateProfile(password: controllerContrasena.text));
                      await Future.delayed(const Duration(seconds: 1),(){
                        setState(() {
                          actualizacion = !actualizacion;
                        });
                      });
                    }
                  )
                ],
              )
          ),
        ),
      ],
    );
  }

  Widget profileImage(){
    return CircleAvatar(
      radius: profileHeight/2,
      backgroundColor: Color(0xFF054F9C),
      child: CircleAvatar(
        radius: (profileHeight/2)-10,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundImage: getImage("https://scontent-gua1-1.xx.fbcdn.net/v/t39.30808-6/270011001_4394168207379141_2498431562754588565_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=aEUaXWH4Zx8AX_zd0cH&_nc_ht=scontent-gua1-1.xx&oh=00_AT-4Oo8_66LMCtK5UPevejHgJjImBxkgbJCjOzdSWrCMlQ&oe=628DDD34"),
      )
      ,
    );
  }

  Widget construirContenedor(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        )
      ),
    );
  }

  

  ImageProvider? getImage(photoUrl){
    if(photoUrl != ""){
      return NetworkImage(photoUrl);
    }else{
      return const AssetImage("assets/images/iconoFacebook.png");
    }
  }
}