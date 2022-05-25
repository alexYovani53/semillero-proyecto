

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/bloc/user/user_bloc.dart';
import 'package:universales_proyecto/model/chanel_model.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/pages/chat/group/userAvatar.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/repository/firebase_chanel_repository.dart';
import 'package:universales_proyecto/utils/config.dart';

class ConfirmGroup extends StatefulWidget {
  
  List<UserChat> seleccionados;

  ConfirmGroup({Key? key, required this.seleccionados}) : super(key: key);

  @override
  State<ConfirmGroup> createState() => _ConfirmGroupState();
}

class _ConfirmGroupState extends State<ConfirmGroup> {

  late ThemeProvider theme;
  final formKey = GlobalKey<FormState>();
  final contollerTitle = TextEditingController();
  final contollerDescripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);
    theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(        
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Nuevo canal",
          style: TextStyle(
            fontSize: 18.0,
            color:Colors.white
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          if(formKey.currentState!.validate()){
            
            final fecha = DateTime.now().millisecondsSinceEpoch;
            final canal = ChanelModel(
              nombre: contollerTitle.text, 
              administradore: {userBloc.sesion!.uid:userBloc.sesion!.uid},
              creador: userBloc.sesion!.uid, 
              descripcion: contollerDescripcion.text, 
              fechaCreacion: fecha, 
              mensajes: {}, 
              usuarios: UserChat.listToJson(widget.seleccionados)
            );
            final repo = FirebaseChanelRepository();
            repo.crearCanal(canal);

            Navigator.pop(context,true);

          }else{
            showFlushBar("Crear canal", "El nombre no puede estar vacio", context);
            await Future.delayed(Duration(seconds: 2),(){
              formKey.currentState!.reset();
            });
          }

          
        },
        child: const Icon(
          Icons.check,
          size: 20
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: theme.getTheme ==ThemeMode.light?Color.fromARGB(255, 241, 232, 232):null,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color:theme.getTheme ==ThemeMode.light?Colors.white:kBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color:theme.getTheme ==ThemeMode.light? Color.fromARGB(255, 66, 62, 62):Color.fromARGB(255, 136, 135, 135),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0,5)
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage("assets/images/icono.png"),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: 30,
                            decoration: BoxDecoration(
                            ),
                            child: TextFormField(
                              controller: contollerTitle,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: "Escribe el asunto aquí"
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty) return "Ingrese un titulo";
                                return null; 
                              },
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: TextFormField(
                          controller: contollerDescripcion,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Escribe la descripcion"
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty) return null;
                            return null; 
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
                  child: Text("Participantes: 1"),
                ),
                Container(
                  height: 350,
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(widget.seleccionados.length, (index) {
                      return Center(
                        child: UserAvatar(usuario: widget.seleccionados[index], onTap: (){}, showButton: false)
                      );
                    })
                  ) ,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showFlushBar(String titulo, String texto,BuildContext context){
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