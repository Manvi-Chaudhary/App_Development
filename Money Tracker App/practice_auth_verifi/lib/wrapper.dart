import 'package:flutter/material.dart';
import 'authenticate.dart';
import 'package:provider/provider.dart';
import 'package:practiceauthverifi/usermodel.dart';
import 'welcome.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);
    print(user);
    if (user != null) {
      return Welcome(
        uid: user.uid,
      );
    } else {
      return Authenticate();
    }
  }
}
