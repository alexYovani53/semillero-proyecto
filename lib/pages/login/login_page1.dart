import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/pages/login/form_login.dart';
import 'package:universales_proyecto/widget/layer1.dart';
import 'package:universales_proyecto/widget/layer2.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';

class LoginPage1 extends StatelessWidget {
  
  LoginPage1({ Key? key }) : super(key: key);

  late ThemeProvider theme;

  @override
  Widget build(BuildContext context) {

    theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient:  LinearGradient(
              stops: const [
                      0.10, 
                      0.70,
                      0.99 
                      ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                    theme.getTheme == ThemeMode.light? Color(0xffFBF6DD):Color(0xffFBF6DD),
                    theme.getTheme == ThemeMode.light? Color(0xff43B3A6):Color(0xff43B3A6),
                    theme.getTheme == ThemeMode.light? Color(0xff2B3139):Color(0xff2B3139),
              ],
            )
          ),
          child: Stack(
            children: [
              Positioned(
                top: 80,
                left: 150,
                child: Container(
                  child: Image.asset(
                    "assets/images/chat.png",
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 59,
                child: Container(
                  child: Text(
                    'Inicio de sesión',
                    style: TextStyle(
                      fontFamily:"lato",
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                )
              ),
              Positioned(top:280,right: 0, bottom: 0, child: Layer1(height: 654,)),
              Positioned(top:308,right: 0, bottom: 28, child: Layer2()),
              Positioned(top:310,right: 0, bottom: 48, child: FormLogin())
            ],
          ),
        ),
      )
    );
          
  }
}