import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff283be7),
        child: Center(
          child: SpinKitRotatingCircle(
            color: Color(0xffffffff),
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
