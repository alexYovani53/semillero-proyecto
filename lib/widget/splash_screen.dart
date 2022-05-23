

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScree extends StatelessWidget{
  const SplashScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Color.fromARGB(255, 1, 88, 160),
        width: MediaQuery.of(context).size.width,        
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo1.png")
              )
            ),
          )
        ),
      ) ,
    );
  }
}