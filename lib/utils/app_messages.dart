
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppMessages{

  AppMessages._privateConstructor();

  static final AppMessages shared = AppMessages._privateConstructor();

  showAlertDialog(BuildContext context,String title, String message, VoidCallback funcion) {  
    // Create button  
    Widget okButton = ElevatedButton(  
      onPressed: () {  
        funcion();
        Navigator.of(context).pop();  
      },  
      child: Text("ok"),
    );  
    
    // Create AlertDialog  
    AlertDialog alert = AlertDialog(  
      title: Text(title),  
      content: Text(message),  
      actions: [  
        okButton,  
      ],  
    );  
    
    // show the dialog  
    showDialog(  
      context: context,  
      builder: (BuildContext context) {  
        return alert;  
      },  
    );  
  }  

}