import 'package:flutter/material.dart';
import 'package:session/model/model.dart';
import 'package:session/db/dbHelper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: FutureBuilder(
          future: userHelper.getUser(name, email, password),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Text("Error");
            } else {
              return Container(
                child: ListView.builder(itemBuilder: (context, int index) {
                  return Text(snapshot.data[user.name]);
                }),
              );
            }
          }),
    );
  }
}
