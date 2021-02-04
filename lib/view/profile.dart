import 'package:flutter/material.dart';
import 'package:session/model/model.dart';
import 'package:session/db/dbHelper.dart';
import 'package:session/view/data.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;

  DbHelper userHelper = DbHelper();

  Future<User> future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<User>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Text("${userHelper.getUser(name, email, password)}")
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
