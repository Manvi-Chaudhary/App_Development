import 'package:flutter/material.dart';
import 'package:practiceauthverifi/login.dart';
import 'package:practiceauthverifi/signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  bool login = true;
  void toggleview() {
    setState(() {
      login = !login;
    });
  }

  Widget build(BuildContext context) {
    if (login) {
      return LoginPage(toggle: toggleview);
    } else {
      return SignupPage(toggle: toggleview);
    }
  }
}
