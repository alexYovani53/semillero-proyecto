

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universales_proyecto/model/mesaje_model.dart';
import 'package:universales_proyecto/utils/config.dart';

class Message extends StatefulWidget {

  bool isSender;
  MesajeModel mensaje;
  Message({
    Key? key,
    required this.isSender, 
    required this.mensaje
  }) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {

  bool mostrarHora = false;
  DateFormat dateFormat = DateFormat.yMd().add_jm(); 


  bool editar =false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          if(widget.mensaje.type!="notification")... [
            Row(
              mainAxisAlignment: 
                widget.isSender? MainAxisAlignment.end: MainAxisAlignment.start,
                children: [
                  if(!widget.isSender)...[
                    CircleAvatar(radius:12,backgroundImage: AssetImage("assets/images/icono.png"),),
                    SizedBox(width: kDefaultPadding/2,)
                  ],
                  Flexible(
                    child: textMessage(context)
                  ),          
                ],
            ),
          ]else...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: textMessageNotification(context)
                  ),          
                ],
            ),
          ],


          if(mostrarHora)...[
            Row(
              mainAxisAlignment: widget.isSender? MainAxisAlignment.end:MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.mensaje.fechaEnvio))
                  )
                ),
              ],
            )
          ]  
        ],
      ),
    );
  }

  Widget textMessage(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          mostrarHora=!mostrarHora;
        });
      },
      onDoubleTap: (){
        setState(() {
          editar = true;
        });
      },
      onHighlightChanged: (v){
          setState(() {            
           editar = false;
          });
        
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding/2),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(widget.isSender ? 1: 0.1),
          borderRadius: BorderRadius.circular(30)
        ),
        child: !editar
          ?Text(
            widget.mensaje.texto,
            style: TextStyle(
              color: widget.isSender 
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1!.color
            ),
          )
          :TextField(

          )
      ),
    );
    
  }
  
  Widget textMessageNotification(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          mostrarHora=!mostrarHora;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding/2),
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: BorderRadius.circular(30)
        ),
        child: Text(
          widget.mensaje.texto,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10
          ),
        ),
      ),
    );
  }
}