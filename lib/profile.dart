import 'package:flutter/material.dart';
import 'package:session/dbHelper.dart';
import 'package:session/home.dart';
import 'package:session/model.dart';
import 'package:session/screen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Profile"),
        ),
      ),
    );
  }
}
