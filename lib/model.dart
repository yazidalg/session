class User {
  int _id;
  String _name;
  String _email;
  String _password;
  String _token;
  String _bio;

  User(this._name, this._email, this._password);

  User.fromMap(Map<String, dynamic> fromMap) {
    _id = fromMap['id'];
    _name = fromMap['name'];
    _email = fromMap['email'];
    _password = fromMap['password'];
    _token = fromMap['token'];
    _bio = fromMap['bio'];
  }

  int get id => _id;

  String get name => _name;

  String get email => _email;

  String get password => _password;

  String get token => _token;

  String get bio => _bio;

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set token(String value) {
    _token = value;
  }

  set bio(String value) {
    _bio = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = this.name;
    map['email'] = this.email;
    map['password'] = this.password;
    map['bio'] = this.bio;
    map['token'] = this.token;
    return map;
  }
}

