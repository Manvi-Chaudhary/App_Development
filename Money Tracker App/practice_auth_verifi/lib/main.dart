import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';
import 'package:practiceauthverifi/usermodel.dart';
import 'package:practiceauthverifi/services/auth.dart';

void main() async {
  const firebaseOptions = FirebaseOptions(
    appId: '1:886850535114:ios:2e0a56143b3137464abe33',
    apiKey: 'AIzaSyB-DFOUoEltagaviVAJYIrfDDBenGTMI0E',
    projectId: 'manvi-app-3aa75',
    messagingSenderId: '886850535114',
  );

  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        // Application name
        title: 'My App',
        theme: ThemeData(
          // Application theme data, you can set the colors for the application as
          // you want
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
