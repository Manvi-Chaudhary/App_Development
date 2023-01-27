import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:practiceauthverifi/services/auth.dart';
import 'package:practiceauthverifi/services/database.dart';
import 'package:practiceauthverifi/total.dart';
import 'package:provider/provider.dart';
import 'datalist.dart';
import 'datamodel.dart';
import 'usermodel.dart';
import 'newform.dart';

class Welcome extends StatefulWidget {
  final String? uid;
  const Welcome({Key? key, this.uid}) : super(key: key);
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Datamodel>>.value(
        value: DatabaseService(uid: widget.uid).data,
        initialData: [],
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xff283be7),
            title: Text("Home Page",
                style: TextStyle(
                  color: Colors.white,
                )),
            actions: <Widget>[
              TextButton.icon(
                  onPressed: (() async {
                    return await _authService.Signout();
                  }),
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Total(),
                SizedBox(height: 20),
                Datalist(uid: widget.uid),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xff283be7),
            onPressed: (() async {
              await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Newform()));
            }),
            icon: Icon(Icons.add),
            label: Text("New Customer"),
          ),
        ));
  }
}
