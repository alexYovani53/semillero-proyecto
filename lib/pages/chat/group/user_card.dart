
import 'package:flutter/material.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/utils/config.dart';

class UserCard extends StatelessWidget {
  
  UserChat usuario;
  
  UserCard({Key? key,required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: usuario.urlImage!=""?NetworkImage(usuario.urlImage): AssetImage("assets/images/usericono.png") as ImageProvider,
              ),
              if(usuario.selected)...[
                Positioned(
                  bottom: -4,
                  right: -5,
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 11,
                    child:Icon(
                      Icons.check,
                      color:Colors.white,
                      size: 18,
                    )
                  ),
                )
              ]
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(usuario.correo),
                  Text(usuario.nombre)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}