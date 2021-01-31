import 'package:flutter/material.dart';
import 'package:session/dbHelper.dart';
import 'package:session/home.dart';
import 'package:session/login.dart';
import 'package:session/model.dart';
import 'package:session/screen.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  User user;

  DbHelper userHelper = DbHelper();

  Future<User> navigateTo(BuildContext context, User user) async {
    var result = await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Screen()));
    return result;
  }

  Future<List<User>> future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = userHelper.getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data.map((e) => cardo(e)).toList(),
            );
          }
          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginForm()));
        },
        elevation: 6,
        child: Icon(Icons.arrow_forward_outlined),
      ),
    );
  }

  Card cardo(User user) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.people),
        ),
        title: Text(
          user.name,
        ),
        onTap: () async {
          int result = await userHelper.deleteUser(user);
          if (result > 0) {
            updateListView();
          }
        },
        subtitle: Text(user.email.toString() +
            ' | Password : ' +
            user.password.toString()),
      ),
    );
  }
}
