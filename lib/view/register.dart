import 'package:flutter/material.dart';
import 'package:session/db/dbHelper.dart';
import 'package:session/view/login.dart';
import 'package:session/model/model.dart';
import 'package:session/view/screen.dart';

class Home extends StatefulWidget {
  final User user;

  Home(this.user);
  @override
  _HomeState createState() => _HomeState(this.user);
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  DbHelper userHelper = DbHelper();
  User user;

  _HomeState(this.user);

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

  String _validateName(String value) {
    if (value.isEmpty) {
      return "Enter your name";
    } else if (value.length < 6) {
      return "Name must be more than 6 character";
    }
    return null;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Enter valid email";
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Enter your password";
    } else if (value.length < 8) {
      return "Password must be more than 8 character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      _name.text = user.name;
      _password.text = user.password;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Session"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  controller: _name,
                  validator: _validateName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: "Name"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  controller: _email,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: TextFormField(
                  controller: _password,
                  validator: _validatePassword,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
              Row(
                children: <Widget>[
                  Builder(
                      builder: (context) => FlatButton(
                          onPressed: () {
                            if (_fromKey.currentState.validate() &&
                                user == null) {
                              user =
                                  User(_name.text, _email.text, _password.text);
                              print("NAMA: ${_name.text}");
                              print("EMAIL : ${_email.text}");
                              print("PASSWORD : ${_password.text}");
                              userHelper.getUser(
                                  _name.text, _email.text, _password.text);
                              userHelper.insertUser(user);
                              _fromKey.currentState.save();
                              updateListView();
                              navigateTo(context, user);
                              return Scaffold.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                elevation: 3.0,
                                content: Text("Register Berhasil"),
                                backgroundColor: Colors.green,
                                action: SnackBarAction(
                                  onPressed: () {},
                                  textColor: Colors.white,
                                  label: "Cancel",
                                ),
                              ));
                            } else {
                              print("Error");
                              return Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Register Gagal"),
                                behavior: SnackBarBehavior.floating,
                                elevation: 3.0,
                                backgroundColor: Colors.red,
                                action: SnackBarAction(
                                  onPressed: () {},
                                  label: "Cancel",
                                  textColor: Colors.white,
                                ),
                              ));
                            }
                          },
                          child: Text("Register"))),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text("Go To Login Form"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
