import 'package:flutter/material.dart';
import 'package:session/home.dart';
import 'package:session/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(user),);
  }
}
