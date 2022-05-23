

import 'package:flutter/material.dart';
import 'package:universales_proyecto/utils/config.dart';

class Layer2 extends StatelessWidget {
  const Layer2({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 399,
      height: 584,
      decoration: const BoxDecoration(
        color: layerTwoBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          bottomLeft: Radius.circular(60.0),
          bottomRight: Radius.circular(60.0)
        )
      ),
    );
  }
}