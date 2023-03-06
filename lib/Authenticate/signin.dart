// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app/services/Authentication.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({Key? key, required this.toggle}) : super(key: key);
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String username = "";
  String password = "";
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(image: AssetImage("assets/images/versace_logo.PNG")),
        SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextFormField(
            onChanged: (value) => username = value,
            validator: ((value) {
              return (value!.isEmpty) ? "Please enter a valid username" : null;
            }),
            decoration: InputDecoration(
                hintText: "Enter Username",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                        width: 10,
                        color: Colors.black,
                        style: BorderStyle.solid))),
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: TextFormField(
            onChanged: (value) => password = value,
            validator: ((value) {
              return (value!.isEmpty) ? "Please enter a Password" : null;
            }),
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Enter Password",
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid))),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Don't have an account?"),
            TextButton(
                onPressed: () {
                  widget.toggle();
                },
                child: Text(
                  "Create",
                ))
          ],
        ),
        SizedBox(height: 20),
        TextButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                await Authservice().signin(username, password);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0Xffb7ea18),
                  borderRadius: BorderRadius.zero,
                  border: Border.all(
                      color: Colors.black, width: 3, style: BorderStyle.solid)),
              height: 50,
              width: 160,
              child: Center(
                child: Text("Sign in",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        backgroundColor: Color(0Xffb7ea18),
                        color: Colors.black)),
              ),
            )),
        TextButton(
            child: Text('sign in anonmously'),
            onPressed: () async {
              await Authservice().signinanon();
            }),
      ]),
    ));
  }
}
