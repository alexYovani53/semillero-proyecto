

import 'package:flutter/material.dart';
import 'package:universales_proyecto/pages/login/config.dart';
import 'package:universales_proyecto/utils/app_types_input.dart';

class TextFormFieldCustom extends StatefulWidget {

  String hintText;
  IconData icono;  
  TypesInput tipo;
  TextEditingController controller;
  bool ocultar;

  TextFormFieldCustom({
    Key? key,
    required this.hintText,
    required this.icono,
    required this.tipo,
    required this.controller,
    required this.ocultar
  }) : super(key: key);

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {

  late bool estado;

  @override
  void initState(){
    estado = widget.ocultar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 172, 172, 172),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icono),
          suffixIcon: 
          widget.ocultar?
            IconButton(
              icon: Icon(Icons.remove_red_eye_outlined),
              onPressed: (){
                setState(() {
                  estado = !estado;
                });
              },
            )
            :null,
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: textInput)
        ),
        autofocus:false,
        controller: widget.controller,
        obscureText: estado,
        validator: (value){
          switch (widget.tipo) {
            case TypesInput.CORREO:
              return validarCorreo(value);
            default:
              return validarTexto(value);
          }
        },
      ),
    );
  }

  String? validarTexto(String? value){
    if(value == null ||  value.isEmpty) return "problema";
  }

  String? validarCorreo(String? value){
    if(value ==null || value.isEmpty) return "problem";
    RegExp regExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(value)?null:"Correo no valido";
  }
}