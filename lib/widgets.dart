import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final VoidCallback callBack;
  final Color color;
  final double size;
  final String text;
  ProductivityButton({required this.callBack,required this.color,required this.size,required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: callBack, color: color,child: Text(text,style: TextStyle(color: Colors.white),),minWidth: size,);
  }
}
