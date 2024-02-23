import 'package:flutter/material.dart';
import 'package:todo/screens/hom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "todo app",
      home: hom(),
    );
  }


  }



