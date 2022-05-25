

import 'package:flutter/material.dart';
import 'package:universales_proyecto/utils/config.dart';

class Message extends StatelessWidget {

  bool isSender;
  Message({
    Key? key,
    required this.isSender
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment: 
          isSender? MainAxisAlignment.end: MainAxisAlignment.start,
          children: [
            if(!isSender)...[
              CircleAvatar(radius:12,backgroundImage: AssetImage("assets/images/icono.png"),),
              SizedBox(width: kDefaultPadding/2,)
              
            ],
            TextMessage(context),
            
          ],
      ),
    );
  }

  Container TextMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding/2),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(isSender ? 1: 0.1),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(
        "Bienvenido",
        style: TextStyle(
          color: isSender 
            ? Colors.white
            : Theme.of(context).textTheme.bodyText1!.color
        ),
      ),
    );
  }
}