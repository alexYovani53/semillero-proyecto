
import 'package:flutter/material.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';

class MessageProvider  with ChangeNotifier{

  static MesajeModel? ms;
  static TextEditingController controllerMs = TextEditingController();

  MesajeModel? get msSelected => ms;
  TextEditingController get controller => controllerMs;

  

  void updateMesage(MesajeModel? nuevo) async {
    if(nuevo==null){
      controllerMs.text = "";
    }else{
      controllerMs.text = nuevo.texto;
    }
    ms = nuevo;
    notifyListeners();
  }


}