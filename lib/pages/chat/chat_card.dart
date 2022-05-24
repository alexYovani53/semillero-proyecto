
import 'package:flutter/material.dart';
import 'package:universales_proyecto/utils/config.dart';

class ChatCard extends StatelessWidget {

  VoidCallback press;

  ChatCard({
    Key? key,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        press();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding*0.75),
        child: Row(
         children:[
           CircleAvatar(
             radius: 24, 
             backgroundImage: AssetImage("assets/images/icono.png"),
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [             
                   Text("AlexYovani"),
                   Text("21 de mayo")
                 ],
               ),
             ),
           )
         ]
        ),
      ),
    );
  }
}