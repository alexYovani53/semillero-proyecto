

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScree extends StatelessWidget{
  const SplashScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,        
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(            
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2c3e50),
              Color(0xFF3498db)
            ]
          )
        ),
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