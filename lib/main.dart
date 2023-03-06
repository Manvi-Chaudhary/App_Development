import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/Authentication.dart';
import 'package:provider/provider.dart';
import 'services/Authentication.dart';

void main() async {
  const firebaseconfig = FirebaseOptions(
      apiKey: "AIzaSyCMRMj7e1SA_KVN5PVMZTDifFciPq3MAuQ",
      appId: "1:436660277800:android:c15c7eb8895ff303d65b1d",
      messagingSenderId: "436660277800",
      projectId: "versace-app");
  await Firebase.initializeApp(options: firebaseconfig);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<String?>.value(
        initialData: null,
        value: Authservice().user,
        child: MaterialApp(
          // Application name
          title: 'Versace App',

          // Application theme data, you can set the colors for the application as
          // you want
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Hanken Grotesk",
          ),
          // A widget which will be started on application startup
          home: Wrapper(),
        ));
  }
}
