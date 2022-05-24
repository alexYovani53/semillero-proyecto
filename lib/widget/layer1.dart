

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universales_proyecto/provider/theme_provider.dart';
import 'package:universales_proyecto/utils/config.dart';

class Layer1 extends StatelessWidget {

  double height;

  Layer1({ 
    Key? key,
    required this.height
  }) : super(key: key);

  late ThemeProvider theme;

  @override
  Widget build(BuildContext context) {

    theme = Provider.of<ThemeProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: theme.getTheme==ThemeMode.light?layerOneBg:layerOneBgDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0)
        )
      ),
    );
  }
}