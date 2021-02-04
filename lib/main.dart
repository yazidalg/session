import 'package:flutter/material.dart';
import 'package:session/view/register.dart';
import 'package:session/view/login.dart';
import 'package:session/model/model.dart';
import 'package:session/view/profile.dart';
import 'package:session/view/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(user),
      title: "Home",
      routes: {
        '/register' : (context) => Home(user),
        '/login' : (context) => LoginForm(),
        '/home' : (context) => Screen(),
        '/profile' : (context) => Profile()
      },
    );
  }
}
