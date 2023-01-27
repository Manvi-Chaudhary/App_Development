import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practiceauthverifi/resetpassword.dart';
import 'package:practiceauthverifi/services/auth.dart';
import 'package:practiceauthverifi/signup.dart';
import 'loading.dart';

class LoginPage extends StatefulWidget {
  final Function toggle;
  const LoginPage({
    Key? key,
    required this.toggle,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService _authService = AuthService();

  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    String geterror(String str) {
      String nerror = "";
      int l = str.indexOf(']');
      for (int i = l + 1; i < str.length; i++) {
        nerror = nerror + str[i];
      }
      return nerror;
    }

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w,
                      height: 210,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/user.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Manvi App",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              validator: (value) => (value!.isEmpty)
                                  ? "Enter a valid email"
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                hintText: 'email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              validator: (value) => value!.length < 6
                                  ? "Password should atleast be 6 characters long"
                                  : null,
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                hintText: 'password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 180),
                      child: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPass(),
                            )),
                        child: Text(
                          "forgot your password ?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: w * 0.4,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Center(
                          child: TextButton(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print("all valid");
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService.signinpass(
                                    email, password);

                                if (result != null) {
                                  print("${result.uid} signed in successfully");
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                  final snack1 = SnackBar(
                                      content: Text(
                                        'signed in failed',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack1);
                                }
                              }
                            },
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/manvi_app.PNG"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    /*SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await _authService.SigninAnon();
                        },
                        child: Container(
                          width: w * 0.6,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Center(
                            child: Text(
                              "Sign In Anonymously",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("assets/manvi_app.PNG"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    SizedBox(height: 50),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                widget.toggle();
                              },
                              child: Text("Create",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          );
  }
}
