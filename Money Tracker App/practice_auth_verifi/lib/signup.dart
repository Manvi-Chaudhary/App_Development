import 'package:firebase_auth/firebase_auth.dart';
import 'package:practiceauthverifi/services/auth.dart';
import 'package:flutter/material.dart';
import 'loading.dart';

class SignupPage extends StatefulWidget {
  final Function toggle;
  const SignupPage({Key? key, required this.toggle}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SignupPage> createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
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
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(50),
                width: w,
                height: 210,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/user.png"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) =>
                            (value!.isEmpty) ? "Enter a valid email" : null,
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
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an account ? ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      TextButton(
                        child: Text("Sign In",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          widget.toggle();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Container(
                  width: w * 0.4,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print("all valid");
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _authService.signuppass(email, password);

                          if (result != null) {
                            print("${result.uid} signed up successfully");
                          } else {
                            setState(() {
                              loading = false;
                            });
                            final snack1 = SnackBar(
                              content: Text(
                                'Please Enter valid credentials',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack1);
                          }
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
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
            ]),
          );
  }
}
