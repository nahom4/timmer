import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductivityButton extends StatelessWidget {
  final VoidCallback callBack;
  final Color color;
  final double size;
  final String text;
  ProductivityButton(
      {required this.callBack,
      required this.color,
      required this.size,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: callBack,
      color: color,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: size,
    );
  }
}

typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  String setting;
  CallbackSetting callBack;

  SettingButton({required this.color, required this.text, required this.value,required this.setting,required this.callBack});
  int time = 0;

  Widget build(BuildContext context) {
 

    return MaterialButton(
      onPressed: () => callBack(setting,value),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      color: color,
    );
  }
}
