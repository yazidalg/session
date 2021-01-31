import 'package:flutter/material.dart';
import 'package:session/home.dart';
import 'package:session/login_response.dart';
import 'package:session/model.dart';
import 'package:session/screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  LoginResponse loginRes = LoginResponse();
  User user;
  String token;

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _email,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _password,
                  validator: _validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
              Row(
                children: <Widget>[
                  Builder(
                      builder: (context) => FlatButton(
                          onPressed: () async {
                            var email = _email.text;
                            var password = _password.text;
                            if (_formKey.currentState.validate() &&
                                await loginRes.checkAuth(email, password)) {
                              return Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Berhasil Login"),
                                backgroundColor: Color(0xFF00af91),
                                behavior: SnackBarBehavior.floating,
                                action: SnackBarAction(
                                  textColor: Colors.white,
                                  label: "Cancel",
                                  onPressed: () {},
                                ),
                              ));
                            } else {
                              return Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Login Gagal",
                                ),
                                backgroundColor: Color(0xFFec4646),
                                behavior: SnackBarBehavior.floating,
                                action: SnackBarAction(
                                  textColor: Colors.white,
                                  label: "Cancel",
                                  onPressed: () {},
                                ),
                              ));
                            }
                          },
                          child: Text("Login"))),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(user)));
                      },
                      child: Text("Go To Register"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
