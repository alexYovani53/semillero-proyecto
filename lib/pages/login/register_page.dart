

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/pages/login/form_register.dart';
import 'package:universales_proyecto/widget/layer1.dart';
import 'package:universales_proyecto/widget/layer2.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';

class RegisterPage extends StatefulWidget {
  
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                    theme.getTheme == ThemeMode.light? Color(0xffFBF6DD):Color(0xFFE0DCC5),
                    theme.getTheme == ThemeMode.light? Color(0xff43B3A6):Color.fromARGB(255, 51, 138, 128),
                    theme.getTheme == ThemeMode.light? Color(0xff2B3139):Color.fromARGB(255, 27, 31, 36),
              ],
            )
          ),
          child: Stack(
            children: [
              Positioned(
                top: 80,
                left: 59,
                child: Container(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                )
              ),              
              Positioned(top:150,right: 0, bottom: 0, child: Layer1(height: MediaQuery.of(context).size.height - 50,)),
              Positioned(top:168,right: 0, bottom: 28, child: Layer2()),
              Positioned(top:180,right: 0, bottom: 48, child: FormRegister())

            ],
          ),
        ),
      )
    );
  }
}