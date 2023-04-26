import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Time management app',
  theme: ThemeData(
  primarySwatch: Colors.blueGrey,
  ),
  home: Home()
));
