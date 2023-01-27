import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practiceauthverifi/services/auth.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  String email = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String geterror(String str) {
      String nerror = "";
      int l = str.indexOf(']');
      for (int i = l + 1; i < str.length; i++) {
        nerror = nerror + str[i];
      }
      return nerror;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff283be7),
        elevation: 0,
        title: Text('Password Reset'),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Container(
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
                      fillColor: Color(0xffaed4d9),
                      label: Text("Email",
                          style: TextStyle(color: Color(0xff053053))),
                      hintText: "enter email",
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print("all valid");
                      print(email.trim());
                      dynamic res = await AuthService().resetpass(email.trim());
                      if (res == null) {
                        final snack1 = SnackBar(
                          content: Text(
                            'Email has been sent on ${email}',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack1);
                      } else {
                        final snack2 = SnackBar(
                            content: Text(
                              '${geterror(res)}',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red);
                        ScaffoldMessenger.of(context).showSnackBar(snack2);
                      }
                    }
                  },
                  child: Container(
                      height: 30,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/manvi_app.PNG'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'Send Password Reset Email',
                        style: TextStyle(color: Colors.white),
                      ))))
            ],
          )),
    );
  }
}
