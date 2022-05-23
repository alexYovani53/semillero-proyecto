

import 'package:flutter/material.dart';
import 'package:universales_proyecto/utils/config.dart';

class Layer1 extends StatelessWidget {

  double height;

  Layer1({ 
    Key? key,
    required this.height
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration:const  BoxDecoration(
        color: layerOneBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0)
        )
      ),
    );
  }
}