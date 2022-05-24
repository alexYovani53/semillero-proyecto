

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/config.dart';

class Layer2 extends StatelessWidget {
  
  Layer2({ Key? key }) : super(key: key);

  late ThemeProvider theme;

  @override
  Widget build(BuildContext context) {
    
    
    theme = Provider.of<ThemeProvider>(context);

    return Container(
      width: 399,
      height: 584,
      decoration: BoxDecoration(
        color: theme.getTheme == ThemeMode.light?layerTwoBg:layerTwoBgDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          bottomLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0)
        )
      ),
    );
  }
}