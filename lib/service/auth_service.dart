import 'dart:math';

class AuthService {
  //Login Method
  Future<bool> login() async {
    return await Future<bool>.delayed(
        new Duration(
          seconds: 4,
        ),
        () => new Random().nextBool());
  }

  //Logout Method
  Future<void> logout() async {
    return await new Future<void>.delayed(new Duration(
      seconds: 5,
    ));
  }
}
