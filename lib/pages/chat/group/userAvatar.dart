

import 'package:flutter/material.dart';
import 'package:universales_proyecto/model/user_chat.dart';
import 'package:universales_proyecto/utils/config.dart';



class UserAvatar extends StatelessWidget {

  UserChat usuario;
  bool showButton;
  VoidCallback onTap;

  UserAvatar({Key? key,required this.usuario,required this.onTap,required this.showButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                
                radius: 30,
                backgroundImage: usuario.urlImage!=""?NetworkImage(usuario.urlImage): AssetImage("assets/images/usericono.png") as ImageProvider,
              ),
              if(usuario.estado)...[
                Positioned(
                  top: 0,
                  left: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 9,
                  ),
                )
              ],
              if(usuario.selected && showButton)...[
                Positioned(
                  bottom: -4,
                  right: -5,
                  child: InkWell(
                    onTap: onTap,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey[200],
                      radius: 15,
                      child: const Icon(
                        Icons.clear,
                        color:Colors.white,
                        size: 18,
                      )
                    ),
                  ),
                )
              ]
            ],
          ),
          Text(
            usuario.nombre,
            style: const TextStyle(
              fontSize: 12,
              overflow: TextOverflow.ellipsis
            )
          )
        ],
      ),
    );
  }
}