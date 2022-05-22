

import 'package:flutter/material.dart';
import 'package:universales_proyecto/pages/login/config.dart';
import 'package:universales_proyecto/utils/app_types_input.dart';

class TextFormFieldCustom extends StatelessWidget {

  String hintText;
  IconData icono;
  
  TypesInput tipo;

  TextEditingController controller;

  TextFormFieldCustom({
    Key? key,
    required this.hintText,
    required this.icono,
    required this.tipo,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: Icon(icono),
        border: const UnderlineInputBorder(),
        hintText: hintText,
        hintStyle: TextStyle(color: hintTextColor)
      ),
      autofocus:false,
      controller: controller,
      validator: (value){
        switch (tipo) {
          case TypesInput.CORREO:
            return validarCorreo(value);
          default:
            return validarTexto(value);
        }
      },
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