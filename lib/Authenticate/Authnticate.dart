import 'package:app/Authenticate/signin.dart';
import 'package:app/Authenticate/signup.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  bool sign_in = true;
  void toggleview() {
    setState(() {
      sign_in = !sign_in;
    });
  }

  Widget build(BuildContext context) {
    return (sign_in) ? SignIn(toggle: toggleview) : SignUp(toggle: toggleview);
  }
}
